# Google Sign-In Setup Guide

## Problem Diagnosed
Your Google Sign-In is failing with error code 10 (`ApiException: 10`) because of missing Firebase/Google Services configuration.

## What I've Fixed
1. ✅ Added Google Services plugin to `android/build.gradle.kts`
2. ✅ Added Google Services plugin to `android/app/build.gradle.kts`
3. ✅ Created template `google-services.json` file

## What You Need to Do
### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or use existing project
3. Enter project name (e.g., "EduMatch")
4. Enable Google Analytics (optional)
5. Click "Create project"

### Step 2: Add Android App to Firebase
1. In Firebase Console, click "Add app" → Android icon
2. Enter package name: `com.neuedumatch.edumatch`
3. Enter app nickname: "EduMatch Android"
4. Leave SHA-1 blank for now (we'll add it later)
5. Click "Register app"

### Step 3: Download google-services.json
1. Download the `google-services.json` file from Firebase
2. Replace the template file at `android/app/google-services.json` with the downloaded file

### Step 4: Get SHA-1 Fingerprint
Run this command in your project root to get your debug SHA-1:

```bash
cd android && ./gradlew signingReport
```

Look for the SHA1 fingerprint under "Variant: debug" → "Config: debug"
SHA1: FD:6A:70:F7:1D:0B:F1:16:30:B4:A3:FF:29:D1:8D:2E:61:35:01:6E

### Step 5: Add SHA-1 to Firebase
1. In Firebase Console, go to Project Settings
2. Select your Android app
3. Click "Add fingerprint"
4. Paste your SHA-1 fingerprint
5. Click "Save"

### Step 6: Enable Google Sign-In
1. In Firebase Console, go to "Authentication"
2. Click "Get started" if not already enabled
3. Go to "Sign-in method" tab
4. Click "Google" provider
5. Toggle "Enable"
6. Enter your project support email: edumatch9@gmail.com, code: neuedumatch@
7. Click "Save"

### Step 7: Get Web Client ID (Important!)
1. In Firebase Console, go to Project Settings
2. Select your Android app
3. Scroll down to "Web API Key" section
4. Copy the "Web client ID": AiZaSyAeV9jWN6fM0Pf4A9tBQvGfCRYdTiRzBkU
5. Update your Flutter code if neededc

### Step 8: Update GoogleSignIn Configuration (Optional)
If you need to specify the web client ID explicitly, update `lib/services/user_service.dart`:

```dart
static final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  serverClientId: 'AiZaSyAeV9jWN6fM0Pf4A9tBQvGfCRYdTiRzBkU', // Add this line
);
```

### Step 9: Clean and Rebuild
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean
cd .. && flutter run
```

## Troubleshooting

### If you still get error 10:
1. Verify package name matches exactly: `com.neuedumatch.edumatch`
2. Ensure SHA-1 fingerprint is added to Firebase
3. Make sure you're using the correct `google-services.json`
4. Try generating a release SHA-1 if testing release builds

### For release builds:
Generate release SHA-1:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### Common Issues:
- **Wrong package name**: Must match `com.neuedumatch.edumatch`
- **Missing SHA-1**: Required for authentication
- **Wrong google-services.json**: Must be from your Firebase project
- **Cache issues**: Run `flutter clean` and rebuild

## Testing
After setup, test Google Sign-In:
1. Run the app: `flutter run`
2. Navigate to login screen
3. Tap Google Sign-In button
4. Should open Google account picker
5. Select account and sign in

## Support
If issues persist:
1. Check Firebase Console logs
2. Enable debug logging in GoogleSignIn
3. Verify all configuration steps above
