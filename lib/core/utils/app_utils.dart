import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppUtils {
  static void printLog(var log) {
    if (kDebugMode) {
      debugPrint('$log');
    }
  }

  static void printFormattedLog(var logText, {String? title}) {
    if (kDebugMode) {
      String tempPattern = "==============================================================";
      if (title != null) {
        final totalLength = tempPattern.length;
        final paddingLength = (totalLength - title.length) ~/ 2;
        final leftPadding = '=' * paddingLength;
        final rightPadding = '=' * (totalLength - title.length - paddingLength);
        log('$leftPadding$title$rightPadding');
      } else {
        log(tempPattern);
      }
      debugPrint("$logText");
      log(tempPattern);
    }
  }

  static Future<bool> checkInterNetConnection() async {
    if (kIsWeb) {
      try {
        final result = await http.get(Uri.parse('www.google.com'));
        if (result.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          printLog('Internet Connected');
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        printLog('No Internet Connection');
        return false;
      }
    }
  }
}
