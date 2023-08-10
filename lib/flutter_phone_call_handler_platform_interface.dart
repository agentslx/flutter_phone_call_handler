import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_phone_call_handler_method_channel.dart';

abstract class FlutterPhoneCallHandlerPlatform extends PlatformInterface {
  /// Constructs a FlutterPhoneCallHandlerPlatform.
  FlutterPhoneCallHandlerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPhoneCallHandlerPlatform _instance = MethodChannelFlutterPhoneCallHandler();

  /// The default instance of [FlutterPhoneCallHandlerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPhoneCallHandler].
  static FlutterPhoneCallHandlerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPhoneCallHandlerPlatform] when
  /// they register themselves.
  static set instance(FlutterPhoneCallHandlerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> endCall() {
    throw UnimplementedError('endCall() has not been implemented.');
  }

  Future<bool?> requestPermissions() {
    throw UnimplementedError('requestPermissions() has not been implemented.');
  }

  Future<bool?> checkPermissions() {
    throw UnimplementedError('checkPermissions() has not been implemented.');
  }
}
