import 'dart:io';

import 'package:news_demo/helpers/snackbar_helper.dart';

class AppException implements Exception {
  //un_known error code -> 0

  late String message;
  String? tag;
  int errorCode;

  AppException({required this.message, required this.errorCode, this.tag});

  int getErrorCode() => errorCode;

  String getMessage() => message;

  String getMessageWithTag() => "${tag ?? 'No Tag'} : $message";

  String? getTag() => tag;

  @override
  String toString() {
    return "${errorCode.toString()} : ${tag ?? 'No Tag'} : $message";
  }

  static void showException(dynamic exception, [dynamic stackTrace]) async {
    if (exception is SocketException) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          AppException(
            message: exception.message,
            errorCode: exception.osError?.errorCode ?? 0,
          ).show();
        }
      } on SocketException catch (_) {
        AppException(
          message: "Check your Internet",
          errorCode: exception.osError?.errorCode ?? 0,
        ).show();
      }
    } else if (exception is HttpException) {
      AppException(message: "Could Not Find Data", errorCode: 0).show();
    } else if (exception is FormatException) {
      AppException(message: "Bad request", errorCode: 0).show();
    } else {
      AppException(message: "Something went Wrong", errorCode: 0).show();
    }
  }

  void show() {
    AppSnackBar.showErrorSnackBar(message: message, title: "Error");
  }
}
