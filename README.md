# flutter_phone_call_handler

Allow handle a call from flutter, for example, end a call.

## Getting Started

```dart
import 'package:flutter_phone_call_handler/flutter_phone_call_handler.dart';

final _flutterPhoneCallHandlerPlugin = FlutterPhoneCallHandler();

// Request permission
await _flutterPhoneCallHandlerPlugin.requestPermissions();

// End call
var success = await _flutterPhoneCallHandlerPlugin.endCall();

```

## Android

Required permissions:

```xml
<uses-permission android:name="android.permission.ANSWER_PHONE_CALLS" />
```

