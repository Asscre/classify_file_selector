import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class VideoWidget extends StatelessWidget {
  final FileModelUtil val;
  final double width;
  final double height;

  VideoWidget(this.val, {this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width ?? ScreenUtil().setWidth(180),
      width: height ?? ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 246, 249, 1),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
      ),
      // child: Text(e.fileName),
      child: Image.memory(
        val.videoImg,
        fit: BoxFit.fill,
      ),
    );
  }
}
