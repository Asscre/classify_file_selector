import 'package:classify_file_selector/page/classify_file_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

/// 安卓端 UI
class SelectFilePage extends StatefulWidget {
  @override
  _SelectFilePageState createState() => _SelectFilePageState();
}

class _SelectFilePageState extends State<SelectFilePage> {
  @override
  Widget build(BuildContext context) {
    double picW = MediaQuery.of(context).size.width;
    double picH = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(picW ?? 720, picH ?? 1334),
      allowFontScaling: false,
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text(
            '选择文件',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(244, 246, 249, 1),
          elevation: 0,
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(22)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '取消',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(20)),
                ),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            body: Builder(builder: (BuildContext context) => _body()),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(244, 246, 249, 1),
      child: Column(
        children: <Widget>[
          //  筛选
          _searchWidget(),
          SizedBox(height: ScreenUtil().setWidth(10)),
          // 列表
          Expanded(child: ClassifyFilePage()),
        ],
      ),
    );
  }

  /// 搜索
  Widget _searchWidget() {
    return Container(
      width: ScreenUtil().setWidth(330),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40))),
      ),
      child: TextField(
        cursorRadius: Radius.circular(3),
        cursorColor: Color.fromRGBO(81, 182, 239, 1),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: '搜索文件',
          hintStyle: TextStyle(
            color: Color.fromRGBO(183, 185, 195, 1),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
        ),
      ),
    );
  }
}
