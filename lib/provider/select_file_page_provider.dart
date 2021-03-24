import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:classify_file_selector/comm/comm_util.dart';
import 'package:permission_handler/permission_handler.dart';

import '../comm/comm.dart';
import '../model/file_util_model.dart';

class SelectFilePageProvider with ChangeNotifier {
  ///  选择的文件
  List<FileModelUtil> fileSelect = [];

  ///  解析到的原生返回的数据
  List<FileModelUtil> fileList = [];

  ///  文件类型
  List<String> fileTypeEnd = [];

  PageController mPageController;

  /// 最大可选
  int maxCount;

  bool loading = true;

  SelectFilePageProvider(List<String> fileTypeEndParams, int maxCountParams) {
    mPageController = PageController(initialPage: 0);
    fileTypeEnd = fileTypeEndParams;
    maxCount = maxCountParams ?? 9;

    _getFilesAndroid();
  }

  /// todo:  调用原生 得到文件+文件信息
  void _getFilesAndroid() async {
    try {
      // 校验权限
      if (await Permission.storage.request().isGranted) {
        Map<String, Object> map = {Comm.TYPE: fileTypeEnd};
        // 将后缀发给原生，原生返回文件集合
        final String dataStr =
            await Comm.CHANNEL.invokeMethod(Comm.GET_FILE, map);
        List<dynamic> listFileStr = jsonDecode(dataStr);
        loading = false;
        fileList.clear();
        listFileStr.forEach((f) {
          File _d = File(f["filePath"]);
          fileList.add(FileModelUtil(
            fileDate: f["fileDate"],
            fileName: f["fileName"],
            filePath: f["filePath"],
            fileSize: f["fileSize"],
            file: _d,
            fileDateStr: _d.statSync().changed.toString().substring(0, 19),
            fileSizeStr: (_d.statSync().size / 1024 / 1024).toStringAsFixed(2),
            fileImage: CommUtil.fileLogo(f["filePath"])["png"],
          ));
        });
        notifyListeners();
      } else {
        _snackBarMsg('当前设备未允许读写权限，无法检索文件!');
      }
    } catch (e) {
      print("FlutterFileSelect Error:" + e.toString());
    }
  }

  /// 筛选
  void screenFile(value) {
    fileSelect = [];
    if (value[0] == "全部") {
      fileTypeEnd = fileTypeEnd;
      _getFilesAndroid();
    } else {
      fileTypeEnd = value;
      _getFilesAndroid();
    }
  }

  /// 选择文件
  void selectFile(int index) {
    if (!fileSelect.contains(fileList[index])) {
      /// todo:  等于最大可选 拦截点击 并提示
      if (maxCount == fileSelect.length) {
        _snackBarMsg('最多可选$maxCount个文件');
        return;
      }
      fileSelect.add(fileList[index]);
    } else {
      fileSelect.removeAt(fileSelect.indexOf(fileList[index]));
    }
    notifyListeners();
  }

  bool check(int index) {
    return fileSelect.contains(fileList[index]);
  }

  /// todo: 底部通知
  _snackBarMsg(msg) {
    // Scaffold.of(ctx).removeCurrentSnackBar();
    // Scaffold.of(ctx).showSnackBar(
    //   SnackBar(content: new Text(msg)),
    // );
  }
}
