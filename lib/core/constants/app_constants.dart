import 'dart:io';

class AppConstants {
  // App metadata
  static const String appName = 'Permission Tester';
  static const String appVersion = '1.0.0';

  // Feature names
  static const String cameraFeature = 'Camera Test';
  static const String comingSoonFeature = 'Coming Soon';

  // Routes
  static const String cameraRoute = '/camera';
  static const String comingSoonRoute = '/coming-soon';

  // Messages
  static String get cameraPermissionDenied => Platform.isIOS 
      ? 'Please allow camera access in Settings to use this feature'
      : 'Camera permission was denied';
      
  static String get cameraPermissionPermanentlyDenied => Platform.isIOS
      ? 'Camera access is restricted. Please check Settings > Privacy > Camera'
      : 'Camera permission is permanently denied, please enable it from app settings';
}