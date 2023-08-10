import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_phone_call_handler_platform_interface.dart';

/// An implementation of [FlutterPhoneCallHandlerPlatform] that uses method channels.
class MethodChannelFlutterPhoneCallHandler extends FlutterPhoneCallHandlerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_phone_call_handler');

  @override
  Future<bool?> endCall() async {
    final success = await methodChannel.invokeMethod<bool>('endCall');
    return success;
  }

  @override
  Future<bool?> requestPermissions() async {
    final success = await methodChannel.invokeMethod<bool>('requestPermissions');
    return success;
  }

  @override
  Future<bool?> checkPermissions() async {
    final success = await methodChannel.invokeMethod<bool>('checkPermissions');
    return success;
  }
}
