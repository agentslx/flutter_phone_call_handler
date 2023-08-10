
import 'flutter_phone_call_handler_platform_interface.dart';

class FlutterPhoneCallHandler {
  Future<bool?> endCall() {
    return FlutterPhoneCallHandlerPlatform.instance.endCall();
  }

  Future<bool?> requestPermissions() {
    return FlutterPhoneCallHandlerPlatform.instance.requestPermissions();
  }

  Future<bool?> checkPermissions() {
    return FlutterPhoneCallHandlerPlatform.instance.checkPermissions();
  }
}
