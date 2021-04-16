import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:classify_file_selector/comm/comm.dart';
import 'package:classify_file_selector/comm/comm_util.dart';
import 'package:classify_file_selector/model/classify_file_item_model.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ClassifyFilePageProvider with ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);

  ///  选择的文件
  List<FileModelUtil> fileSelect = [];

  bool loading = false;

  List<ClassifyFileItemModel> classifyBarList = [
    ClassifyFileItemModel(CommUtil.imgExpandName, true, '图片'),
    ClassifyFileItemModel(CommUtil.videoExpandName, false, '视频'),
    ClassifyFileItemModel(CommUtil.musicExpandName, false, '音乐'),
    ClassifyFileItemModel(CommUtil.officeExpandName, false, '文件'),
    ClassifyFileItemModel(CommUtil.rarExpandName, false, '其他'),
  ];

  int selectIndex = 0;

  /// 文件类型
  List<FileModelUtil> imgFileList = [];
  List<FileModelUtil> videoFileList = [];
  List<FileModelUtil> musicFileList = [];
  List<FileModelUtil> officeFileList = [];
  List<FileModelUtil> rarFileList = [];

  ClassifyFilePageProvider() {
    for (int i = 0; i < classifyBarList.length; i++) {
      _getFilesAndroid(classifyBarList[i].fileTypeEnd, i);
    }
  }

  void switchClassify(int i, BuildContext ctx) {
    classifyBarList.forEach((e) {
      e.isSelect = false;
    });
    classifyBarList[i].isSelect = true;
    pageController.jumpToPage(i);
    notifyListeners();
  }

  void _getFilesAndroid(List<String> fileTypeEnd, int i) async {
    try {
      // 校验权限
      if (await Permission.storage.request().isGranted) {
        Map<String, Object> map = {Comm.TYPE: fileTypeEnd};
        // 将后缀发给原生，原生返回文件集合
        final String dataStr =
            await Comm.CHANNEL.invokeMethod(Comm.GET_FILE, map);
        List<dynamic> listFileStr = jsonDecode(dataStr);

        List<FileModelUtil> fileList = [];
        listFileStr.forEach((f) async {
          File _d = File(f["filePath"]);
          if (i == 0) {
            fileList.add(FileModelUtil(
              fileDate: f["fileDate"],
              fileName: f["fileName"],
              filePath: f["filePath"],
              fileSize: f["fileSize"],
              file: _d,
              fileDateStr: _d.statSync().changed.toString().substring(0, 19),
              fileSizeStr:
                  (_d.statSync().size / 1024 / 1024).toStringAsFixed(2),
              fileImage: CommUtil.fileLogo(f["filePath"])["png"],
            ));
          } else if (i == 1) {
            fileList.add(FileModelUtil(
              fileDate: f["fileDate"],
              fileName: f["fileName"],
              filePath: f["filePath"],
              fileSize: f["fileSize"],
              file: _d,
              fileDateStr: _d.statSync().changed.toString().substring(0, 19),
              fileSizeStr:
                  (_d.statSync().size / 1024 / 1024).toStringAsFixed(2),
              fileImage: CommUtil.fileLogo(f["filePath"])["png"],
              videoImg: await VideoThumbnail.thumbnailData(
                video: f["filePath"],
                imageFormat: ImageFormat.PNG,
                maxWidth: 128,
                quality: 25,
              ),
            ));
          } else {
            fileList.add(FileModelUtil(
              fileDate: f["fileDate"],
              fileName: f["fileName"],
              filePath: f["filePath"],
              fileSize: f["fileSize"],
              file: _d,
              fileDateStr: _d.statSync().changed.toString().substring(0, 19),
              fileSizeStr:
                  (_d.statSync().size / 1024 / 1024).toStringAsFixed(2),
              fileImage: CommUtil.fileLogo(f["filePath"])["png"],
            ));
          }
        });

        switch (i) {
          case 0:
            imgFileList = fileList;
            break;
          case 1:
            videoFileList = fileList;
            break;
          case 2:
            musicFileList = fileList;
            break;
          case 3:
            officeFileList = fileList;
            break;
          case 4:
            rarFileList = fileList;
            break;
        }

        notifyListeners();
      } else {
        // _snackBarMsg('当前设备未允许读写权限，无法检索文件!');
      }
    } catch (e) {
      print("FlutterFileSelect Error:" + e.toString());
    }
  }

  /// 选择文件
  void selectFile(int index, int type) {
    // if (!fileSelect.contains(fileList[index])) {
    //   /// todo:  等于最大可选 拦截点击 并提示
    //   if (maxCount == fileSelect.length) {
    //     _snackBarMsg('最多可选$maxCount个文件');
    //     return;
    //   }
    //   fileSelect.add(fileList[index]);
    // } else {
    //   fileSelect.removeAt(fileSelect.indexOf(fileList[index]));
    // }
    // notifyListeners();
  }

  bool check(int index, int type) {
    // return fileSelect.contains(fileList[index]);
  }
}
