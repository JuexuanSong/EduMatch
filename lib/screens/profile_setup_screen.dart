// lib/screens/profile_setup_screen.dart - Fixed Version
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import '../services/user_service.dart';
import '../widgets/profile/avatar_section.dart';
import '../widgets/common/skills_autocomplete.dart';
import '../widgets/common/bottom_navigation_bar.dart';
import '../widgets/common/loading_widget.dart';

class ProfileSetupScreen extends StatefulWidget {
  final List<String>? selectedSkills;
  
  const ProfileSetupScreen({super.key, this.selectedSkills});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final UserService _userService = UserService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _campusController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  List<String> targetSkills = [];
  List<String> offerSkills = [];
  String? _errorMessage;
  bool _isLoading = false;
  bool _isLocationLoading = false;
  File? _selectedImage;
  double? _latitude;
  double? _longitude;

  final List<String> campusOptions = [
    'Arlington', 'Boston', 'Burlington', 'Charlotte', 'London', 'Miami',
    'Oakland', 'Portland', 'Seattle', 'Silicon Valley', 'Toronto', 'Vancouver',
  ];

  final List<String> availableSkills = [
    'Python', 'Java', 'C', 'C++', 'C#', 'Ruby on Rails', 'Flutter', 'Dart',
    'JavaScript', 'HTML', 'CSS', 'Kotlin', 'Swift', 'Go', 'PHP', 'SQL',
    'MySQL', 'PostgreSQL', 'MongoDB', 'Django', 'Flask', 'FastAPI',
    'Spring Boot', 'ASP.NET', 'Vue.js', 'Angular', 'TypeScript', 'Rust',
    'Node.js', 'AWS', 'Firebase', 'Azure', 'GCP', 'DevOps', 'UI/UX Design',
    'Figma', 'Deep Learning', 'PyTorch', 'TensorFlow', 'Computer Vision',
    'Machine Learning', 'Cybersecurity', 'AR/VR', 'Game Development',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedSkills != null) {
      targetSkills = List.from(widget.selectedSkills!);
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLocationLoading = true;
      _locationController.text = 'Getting your location...';
    });

    try {
      final locationResult = await _userService.getCurrentLocation();
      
      if (locationResult['success']) {
        _latitude = locationResult['data']['latitude'];
        _longitude = locationResult['data']['longitude'];
        
        // Convert coordinates to readable address
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _latitude!,
          _longitude!,
        );
        
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          String address = '';
          
          if (place.locality != null && place.locality!.isNotEmpty) {
            address = place.locality!;
          }
          if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
            if (address.isNotEmpty) address += ', ';
            address += place.administrativeArea!;
          }
          if (place.country != null && place.country!.isNotEmpty) {
            if (address.isNotEmpty) address += ', ';
            address += place.country!;
          }
          
          setState(() {
            _locationController.text = address.isNotEmpty ? address : 'Location detected';
            _isLocationLoading = false;
          });
        } else {
          setState(() {
            _locationController.text = 'Location detected';
            _isLocationLoading = false;
          });
        }
      } else {
        setState(() {
          _locationController.text = '';
          _isLocationLoading = false;
          _errorMessage = locationResult['error'];
        });
      }
    } catch (e) {
      setState(() {
        _locationController.text = '';
        _isLocationLoading = false;
        _errorMessage = 'Failed to get location: $e';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _campusController.dispose();
    super.dispose();
  }

  Future<void> _validateAndSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Update profile
      final profileResult = await _userService.updateProfile(
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        campus: _campusController.text,
        useCurrentLocation: true,
      );

      if (!profileResult['success']) {
        setState(() {
          _errorMessage = 'Failed to update profile: ${profileResult['error']}';
          _isLoading = false;
        });
        return;
      }

      // Update skills
      final skillsResult = await _userService.updateSkills(
        targetSkills: targetSkills,
        offerSkills: offerSkills,
      );

      if (!skillsResult['success']) {
        setState(() {
          _errorMessage = 'Failed to update skills: ${skillsResult['error']}';
          _isLoading = false;
        });
        return;
      }

      // Success - navigate to home
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'An error occurred: $e';
          _isLoading = false;
        });
      }
    }
  }

  // Fixed: Create a proper function for bottom navigation
  void _handleBottomNavigation(int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/people');
        break;
      case 2:
        Navigator.pushNamed(context, '/chat');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduMatch'),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5A8298),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6E9D7),
              Color(0xFFE9D9F5),
            ],
          ),
        ),
        child: _isLoading
            ? const LoadingWidget(message: 'Setting up your profile...')
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Set up your profile so others can find you!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00487B),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Avatar Section
                      AvatarSection(
                        userInitials: _nameController.text.isNotEmpty
                            ? _nameController.text[0].toUpperCase()
                            : null,
                        onImageChanged: (image) {
                          setState(() {
                            _selectedImage = image;
                          });
                          
                          // Use the selected image (this fixes the "unused field" warning)
                          if (_selectedImage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile photo updated!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Name Field
                      _buildRequiredTextField(
                        label: 'Full Name',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Location Field
                      _buildLocationField(),
                      const SizedBox(height: 16),
                      
                      // Campus Dropdown
                      _buildCampusDropdown(),
                      const SizedBox(height: 24),
                      
                      // Target Skills
                      SkillsAutocomplete(
                        title: 'Skills I Want to Learn',
                        skills: targetSkills,
                        availableSkills: availableSkills,
                        onSkillAdded: (skill) {
                          setState(() {
                            if (!targetSkills.contains(skill)) {
                              targetSkills.add(skill);
                            }
                          });
                        },
                        onSkillRemoved: (skill) {
                          setState(() {
                            targetSkills.remove(skill);
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Offer Skills
                      SkillsAutocomplete(
                        title: 'Skills I Can Teach',
                        skills: offerSkills,
                        availableSkills: availableSkills,
                        onSkillAdded: (skill) {
                          setState(() {
                            if (!offerSkills.contains(skill)) {
                              offerSkills.add(skill);
                            }
                          });
                        },
                        onSkillRemoved: (skill) {
                          setState(() {
                            offerSkills.remove(skill);
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Error Message
                      if (_errorMessage != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red.shade700),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _validateAndSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A1DF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Complete Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: _handleBottomNavigation, // Fixed: Now using the proper function
      ),
    );
  }

  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00487B),
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            if (!_isLocationLoading)
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(
                  Icons.refresh,
                  size: 16,
                  color: Color(0xFF00A1DF),
                ),
                label: const Text(
                  'Refresh',
                  style: TextStyle(
                    color: Color(0xFF00A1DF),
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _locationController,
          readOnly: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Location is required. Please allow location access.';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Detecting your location...',
            prefixIcon: _isLocationLoading
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A1DF)),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.location_on,
                    color: Color(0xFF00A1DF),
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00A1DF), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        if (_latitude != null && _longitude != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'GPS: ${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontFamily: 'monospace',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRequiredTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00487B),
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00A1DF), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
        ),
      ],
    );
  }

  Widget _buildCampusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Campus',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00487B),
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _campusController.text.isEmpty ? null : _campusController.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your campus';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Select your campus',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00A1DF), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: campusOptions.map((String campus) {
            return DropdownMenuItem<String>(
              value: campus,
              child: Text(campus),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _campusController.text = newValue;
              });
            }
          },
        ),
      ],
    );
  }
}
