import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ImageWidget extends StatelessWidget {
  final FileModelUtil val;
  final double width;
  final double height;

  ImageWidget(this.val, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil().setWidth(170),
      height: height ?? ScreenUtil().setWidth(170),
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 246, 249, 1),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(208, 215, 219, 1),
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: ExtendedImage(
        image: Image.file(
          val.file,
        ).image,
        fit: BoxFit.cover,
        width: ScreenUtil().setWidth(170),
        height: ScreenUtil().setWidth(170),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
      ),
    );
  }
}
