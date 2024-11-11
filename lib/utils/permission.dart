import 'package:permission_handler/permission_handler.dart';

Future<bool> requestSmsPermission() async {
  PermissionStatus status = await Permission.sms.status;
  if (!status.isGranted) {
    status = await Permission.sms.request();
  }

  return status.isGranted;
}
