package com.example.front_wear

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
//
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler
//import io.flutter.plugin.common.MethodChannel.Result
//
//class MainActivity: FlutterPlugin, MethodCallHandler {
//    private lateinit var channel : MethodChannel
//
//    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.app/wearable")
//        channel.setMethodCallHandler(this)
//    }
//
//    override fun onMethodCall(call: MethodCall, result: Result) {
//        if (call.method == "sendMessage") {
//            val message = call.arguments<String>()
//            sendMessageToWearable(message)
//            result.success("Message sent to wearable")
//        } else {
//            result.notImplemented()
//        }
//    }
//
//    private fun sendMessageToWearable(message: String) {
//        // 여기에 Wear OS로 메시지를 보내는 코드를 구현합니다.
//    }
//
//    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        channel.setMethodCallHandler(null)
//    }
//}
