import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    _setLoading(true);
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
    
    // Check if user is already signed in
    _user = _auth.currentUser;
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Google Sign-In
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return false; // User cancelled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        await _saveAuthMethod('google');
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Failed to sign in with Google: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Apple Sign-In
  Future<bool> signInWithApple() async {
    try {
      _setLoading(true);
      _setError(null);

      // Check if Apple Sign In is available
      if (!await SignInWithApple.isAvailable()) {
        _setError('Apple Sign In is not available on this device');
        _setLoading(false);
        return false;
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your.app.bundle.id',
          redirectUri: Uri.parse('https://your-app.firebaseapp.com/__/auth/handler'),
        ),
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);
      
      if (userCredential.user != null) {
        await _saveAuthMethod('apple');
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Failed to sign in with Apple: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Email Sign-In
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _saveAuthMethod('email');
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } catch (e) {
      _setError(_getFirebaseErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  // Email Sign-Up
  Future<bool> signUpWithEmail(String email, String password, String name) async {
    try {
      _setLoading(true);
      _setError(null);

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update user profile with name
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.reload();
        _user = _auth.currentUser;
        
        await _saveAuthMethod('email');
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } catch (e) {
      _setError(_getFirebaseErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.sendPasswordResetEmail(email: email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(_getFirebaseErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _clearAuthMethod();
    } catch (e) {
      _setError('Failed to sign out: ${e.toString()}');
    }
  }

  // Save authentication method to preferences
  Future<void> _saveAuthMethod(String method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_method', method);
  }

  // Clear authentication method from preferences
  Future<void> _clearAuthMethod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_method');
  }

  // Get preferred auth method for platform
  String getPreferredAuthMethod() {
    if (Platform.isIOS) {
      return 'apple';
    } else if (Platform.isAndroid) {
      return 'google';
    }
    return 'email';
  }

  // Helper method to get user-friendly error messages
  String _getFirebaseErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'weak-password':
          return 'Password is too weak. Please choose a stronger password.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'user-disabled':
          return 'This account has been disabled. Please contact support.';
        case 'too-many-requests':
          return 'Too many failed attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled. Please contact support.';
        default:
          return 'Authentication failed. Please try again.';
      }
    }
    return error.toString();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}