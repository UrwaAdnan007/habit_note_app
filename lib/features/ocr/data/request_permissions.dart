import 'package:permission_handler/permission_handler.dart';

// Function to request camera and storage permissions
Future<void> requestPermissions() async {
  // Requesting camera permission and storing its status
  final cameraStatus = await Permission.camera.request();

  // Requesting storage permission and storing its status
  final storageStatus = await Permission.storage.request();

  // Checking if both permissions are granted
  if (cameraStatus.isGranted && storageStatus.isGranted) {
    // If permissions are granted, print a success message
    print("Permissions granted");
  } else {
    // If any permission is not granted, print a failure message
    print("Permissions not granted");
  }
}
