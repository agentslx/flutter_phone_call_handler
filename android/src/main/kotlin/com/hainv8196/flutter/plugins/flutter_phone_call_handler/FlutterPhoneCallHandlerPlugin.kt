package com.hainv8196.flutter.plugins.flutter_phone_call_handler

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.telecom.TelecomManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPhoneCallHandlerPlugin */
class FlutterPhoneCallHandlerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    private var resultHandler: Result? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_phone_call_handler")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    @RequiresApi(Build.VERSION_CODES.P)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "endCall" -> {
                val success = endPhoneCall()
                result.success(success)
            }

            "requestPermissions" -> {
                requestPermissions()
                result.success(true)
            }

            "checkPermissions" -> {
                result.success(checkPermissions())
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun requestPermissions() {
        val permissionCheck: Int =
            ContextCompat.checkSelfPermission(context, Manifest.permission.ANSWER_PHONE_CALLS)

        if (permissionCheck != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(
                activity,
                arrayOf(Manifest.permission.ANSWER_PHONE_CALLS),
                REQUEST_ANSWER_PHONE_CALLS
            )
        }
    }

    private fun checkPermissions(): Boolean {
        val permissionCheck: Int =
            ContextCompat.checkSelfPermission(context, Manifest.permission.ANSWER_PHONE_CALLS)
        return permissionCheck == PackageManager.PERMISSION_GRANTED
    }


    @RequiresApi(Build.VERSION_CODES.P)
    private fun endPhoneCall(): Boolean {
        val tm: TelecomManager? =
            context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager?

        if (tm != null) {
            // success == true if call was terminated.
            return tm.endCall()
        }
        return false
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivity() {
    }

    companion object {
        private const val REQUEST_ANSWER_PHONE_CALLS = 100
    }
}
