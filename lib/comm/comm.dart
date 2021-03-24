import 'package:flutter/services.dart';

/// 公共类
class  Comm{
  /// 包名
  static const String PACKNAME = "classify_file_selector";
  /// 原生交互通道
  static const MethodChannel CHANNEL = const MethodChannel('classify_file_selector');
  static const String GET_FILE = "GET_FILE";
  static const String TYPE = "TYPE";
}
