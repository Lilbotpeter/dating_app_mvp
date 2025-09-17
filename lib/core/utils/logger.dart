import 'package:flutter/widgets.dart';

class Logger {
  final bool enabled;
  const Logger({this.enabled = true});

  void d(Object? msg){
    if(enabled){
      debugPrint('[D] $msg');
    }
  }

  void e(Object? msg){
    if(enabled){
      print('[E] $msg');
    }
  }
}