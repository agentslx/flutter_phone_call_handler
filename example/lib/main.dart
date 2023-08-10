import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_phone_call_handler/flutter_phone_call_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterPhoneCallHandlerPlugin = FlutterPhoneCallHandler();

  final testPhoneNumber = '0393067227';
  var calling = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await _flutterPhoneCallHandlerPlugin.requestPermissions();
  }

  startCall() async {
    final Telephony telephony = Telephony.instance;
    await telephony.dialPhoneNumber(testPhoneNumber);
  }

  Future<void> endCall() async {
    try {
      var success = await _flutterPhoneCallHandlerPlugin.endCall();
    } on PlatformException {
      print("Failed to end call");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              if (calling) {
                endCall();
              } else {
                startCall();
              }
              setState(() {
                calling = !calling;
              });
            },
            child: Text(calling ? 'End' : 'Call'),
          ),
        ),
      ),
    );
  }
}
