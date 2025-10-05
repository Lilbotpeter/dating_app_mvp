import 'package:dating_china_app_mvp/core/widgets/app_dialog.dart';
import 'package:flutter/material.dart';

extension DialogContext on BuildContext {
  Future<void> showErrorDialog(String message) =>
    AppDialog.showActionSheet<void>(
      context: this,
      title: 'เกิดข้อผิดพลาด',
      message: message,
      actions: const [
        DialogAction(label: 'ปิด', value: null),
      ]
    );

    Future<bool?> showConfirmDialog({
      required String title,
      required String message,
      String confirmText = 'ตกลง',
      String cancelText = 'ยกเลิก'
    }) => 
      AppDialog.showActionSheet<bool>(
        context: this,
        title: title,
        message: message,
        actions: [
          DialogAction(label: cancelText, value: false),
          DialogAction(label: confirmText, value: true),
        ]
      );
}