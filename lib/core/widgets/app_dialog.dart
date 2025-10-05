import 'package:flutter/material.dart';

class AppDialog {
  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    required String title,
    required String message,
    required List<DialogAction<T>> actions,
  }){
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions
        .map((i) => TextButton(
          onPressed: () => Navigator.of(dialogCtx).pop(i.value),
          child: Text(i.label),
        ))
        .toList(),
      )
      
      );
  }
}

class DialogAction<T> {
  final String label;
  final T value;
  const DialogAction({required this.label, required this.value});
}