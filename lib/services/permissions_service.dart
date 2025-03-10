import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  static Future<void> requestPermissions() async {
    await [
      Permission.storage,
      Permission.location,
      Permission.contacts,
    ].request();
  }
}
