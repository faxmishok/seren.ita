import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

Widget errorWidgetBuilder(FlutterErrorDetails error) {
  return SafeArea(
    child: Container(
      color: Colors.indigo,
      padding: spacing16,
      child: SingleChildScrollView(
        child: Text(
          error.toString(),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            height: 1.6,
          ),
        ),
      ),
    ),
  );
}

void logRequestAndResponse(
  String endpoint, {
  dynamic body,
  dynamic requestHeaders,
  dynamic statusCode,
  dynamic responseBody,
  dynamic responseHeaders,
  String? method,
}) {
  if (!kDebugMode) return;

  log('${method != null ? '[$method]' : ''} : ENDPOINT: $endpoint');
  if (body != null) {
    const jsonEncoder = JsonEncoder.withIndent('   ');
    final prettyBody = jsonEncoder.convert(body);
    log('REQUEST BODY:\n$prettyBody');
  }

  if (requestHeaders != null) log('REQUEST HEADERS: $requestHeaders');
  if (statusCode != null) log('STATUS CODE: $statusCode');
  if (responseBody != null && responseBody.trim().isNotEmpty) {
    try {
      const jsonEncoder = JsonEncoder.withIndent('  ');
      final prettyBody = jsonEncoder.convert(jsonDecode(responseBody));
      log('RESPONSE BODY:\n$prettyBody');
    } catch (_) {
      log('RESPONSE BODY:\n$responseBody');
    }
  }
  if (responseHeaders != null) log('RESPONSE HEADERS: $responseHeaders');
}

void logError(dynamic e, dynamic s) {
  if (e != null) debugPrint(e.toString());
  if (s != null) debugPrint(s.toString());

  if (kDebugMode) {
    ///
  }
}
