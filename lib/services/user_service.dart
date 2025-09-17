// lib/services/user_service.dart - Enhanced with PostGIS support
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart'; // For getting current location
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  
  // Google Sign-In configuration
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  
  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Save token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  // Remove token
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  // Get headers with token
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };
  }
  
  // Get current device location
  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return {'success': false, 'error': 'Location services are disabled'};
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return {'success': false, 'error': 'Location permissions are denied'};
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return {'success': false, 'error': 'Location permissions are permanently denied'};
      }

      Position position = await Geolocator.getCurrentPosition();
      
      return {
        'success': true, 
        'data': {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'accuracy': position.accuracy,
        }
      };
    } catch (e) {
      return {'success': false, 'error': 'Failed to get location: $e'};
    }
  }
  
  // User Registration
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register/'),
        headers: await getHeaders(),
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        await saveToken(data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // User Login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login/'),
        headers: await getHeaders(),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        await saveToken(data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Google Sign-In Login
  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      // Sign out first to ensure clean state
      await _googleSignIn.signOut();
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User cancelled the sign-in
        return {'success': false, 'error': 'Google sign-in was cancelled'};
      }
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Send the Google token to your backend
      final response = await http.post(
        Uri.parse('$baseUrl/users/google-login/'),
        headers: await getHeaders(),
        body: json.encode({
          'google_token': googleAuth.idToken,
          'access_token': googleAuth.accessToken,
          'email': googleUser.email,
          'name': googleUser.displayName,
          'photo_url': googleUser.photoUrl,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        await saveToken(data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Google sign-in failed: $e'};
    }
  }
  
  // Sign out from Google
  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      // Ignore errors during sign out
    }
  }
  
  // Get User Profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/profile/'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Update User Profile with PostGIS Location Support
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String location, // This is the text location (e.g., "New York, NY")
    required String campus,
    double? longitude,      // PostGIS longitude
    double? latitude,       // PostGIS latitude
    String? bio,
    bool useCurrentLocation = false, // Auto-detect location
  }) async {
    try {
      final Map<String, dynamic> body = {
        'name': name,
        'location': location, // Text location for display
        'campus': campus,
      };
      
      // Add coordinates for PostGIS
      if (useCurrentLocation) {
        final locationResult = await getCurrentLocation();
        if (locationResult['success']) {
          body['longitude'] = locationResult['data']['longitude'];
          body['latitude'] = locationResult['data']['latitude'];
        }
      } else if (longitude != null && latitude != null) {
        body['longitude'] = longitude;
        body['latitude'] = latitude;
      }
      
      if (bio != null) {
        body['bio'] = bio;
      }
      
      final response = await http.put(
        Uri.parse('$baseUrl/users/profile/'),
        headers: await getHeaders(),
        body: json.encode(body),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Update Profile with Current Location
  Future<Map<String, dynamic>> updateProfileWithCurrentLocation({
    required String name,
    required String location,
    required String campus,
    String? bio,
  }) async {
    return await updateProfile(
      name: name,
      location: location,
      campus: campus,
      bio: bio,
      useCurrentLocation: true,
    );
  }
  
  // Find nearby users (PostGIS spatial query)
  Future<Map<String, dynamic>> findNearbyUsers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0, // Default 10km radius
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/nearby/?lat=$latitude&lng=$longitude&radius=$radiusKm'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Find users by campus and proximity
  Future<Map<String, dynamic>> findUsersByCampusAndProximity({
    required String campus,
    double? latitude,
    double? longitude,
    double radiusKm = 50.0,
  }) async {
    try {
      String url = '$baseUrl/users/campus/$campus/';
      
      if (latitude != null && longitude != null) {
        url += '?lat=$latitude&lng=$longitude&radius=$radiusKm';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Geocode address to coordinates (if you want to convert address to lat/lng)
  Future<Map<String, dynamic>> geocodeAddress({
    required String address,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/geocode/?address=${Uri.encodeComponent(address)}'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Update User Skills
  Future<Map<String, dynamic>> updateSkills({
    required List<String> targetSkills,
    required List<String> offerSkills,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/update-skills/'),
        headers: await getHeaders(),
        body: json.encode({
          'target_skills': targetSkills,
          'offer_skills': offerSkills,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Logout
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/logout/'),
        headers: await getHeaders(),
      );
      
      await removeToken();
      await signOutFromGoogle(); // Also sign out from Google
      
      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'error': 'Logout failed'};
      }
    } catch (e) {
      await removeToken();
      await signOutFromGoogle(); // Also sign out from Google
      return {'success': true};
    }
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
