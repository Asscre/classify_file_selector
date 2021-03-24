import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classify_file_selector/page/select_file_page.dart';
import 'package:classify_file_selector/comm/comm_util.dart';

import 'model/file_util_model.dart';

/// @DevTool: AndroidStudio
/// @Author: Asscre
/// @Date: 2021/3/24 9:58
/// @FileName: ClassifyFileSelector
/// @FilePath: classify_file_selector.dart
/// @Description: 文件选择器

class ClassifyFileSelector extends StatefulWidget {
  final Widget btn; // 按钮
  final List<String> fileTypeEnd; // 文件后缀
  final int maxCount; // 可选最大总数 默认9个
  final ValueChanged<List<FileModelUtil>> valueChanged; // 类型回调

  ClassifyFileSelector({
    this.btn,
    this.fileTypeEnd,
    this.maxCount,
    this.valueChanged,
  });

  @override
  _ClassifyFileSelectorState createState() => _ClassifyFileSelectorState();
}

class _ClassifyFileSelectorState extends State<ClassifyFileSelector> {
  List<String> fileTypeEnd = [];

  @override
  void initState() {
    super.initState();
    fileTypeEnd = widget.fileTypeEnd ??
        [
          ".pdf",
          ".doc",
          ".docx",
          ".xls",
          ".xlsx",
        ];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /// 判断平台
        if (Platform.isAndroid) {
          _getFilesAndroidPage(context);
        } else if (Platform.isIOS) {
          _getFilesIosPage();
        }
      },
      child: widget.btn ?? Text("选择文件"),
    );
  }

  /// Android平台 调用Flutter布局页
  void _getFilesAndroidPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectFilePage(
          maxCount: widget.maxCount,
          fileTypeEnd: widget.fileTypeEnd,
        ),
      ),
    ).then((value) {
      widget.valueChanged(value ?? []);
    });
  }

  ///  IOS平台 直接使用FilePicker插件
  void _getFilesIosPage() async {
    try {
      List<FileModelUtil> list = [];
      List<String> type = [];

      /// 去除点
      widget.fileTypeEnd.forEach((t) {
        type.add(t.substring(t.lastIndexOf(".") + 1, t.length));
      });

      log("当前能选的类型 ios：" + type.toString());

      List<File> files = await FilePicker.getMultiFile(
        type: FileType.custom,
        allowedExtensions: type ?? ["pdf", "docx", "doc"],
      );

      if (files == null || files.length == 0) {
        return;
      }
      files.forEach((f) {
        list.add(FileModelUtil(
          fileDate: f.statSync().changed.millisecondsSinceEpoch,
          fileName: f.resolveSymbolicLinksSync().substring(
              f.resolveSymbolicLinksSync().lastIndexOf("/") + 1,
              f.resolveSymbolicLinksSync().length),
          filePath: f.path,
          fileSize: f.statSync().size,
          file: f,
          fileDateStr: f.statSync().changed.toString().substring(0, 19),
          fileSizeStr: (f.statSync().size / 1024 / 1024).toStringAsFixed(2),
          fileImage: CommUtil.fileLogo(f.path)["png"],
        ));
      });

      widget.valueChanged(list);
    } catch (e) {
      print("FlutterFileSelect Error:" + e.toString());
    }
  }
}
