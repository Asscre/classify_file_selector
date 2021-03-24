import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:classify_file_selector/page/all_file_page.dart';
import 'package:classify_file_selector/page/classify_file_page.dart';
import 'package:classify_file_selector/provider/select_file_page_provider.dart';
import 'package:classify_file_selector/widget/switch_list_button.dart';
import 'package:provider/provider.dart';

/// 安卓端 UI
class SelectFilePage extends StatefulWidget {
  final List<String> fileTypeEnd;
  final int maxCount;

  SelectFilePage({
    this.fileTypeEnd,
    this.maxCount,
  });

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
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SFP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              body: Builder(builder: (BuildContext context) => _body()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return ChangeNotifierProvider(
      create: (_) =>
          SelectFilePageProvider(widget.fileTypeEnd, widget.maxCount),
      builder: (BuildContext ctx, Widget child) {
        ctx = ctx;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              //  筛选
              _diyAppBar(ctx),
              // 列表
              Expanded(child: _pageView(ctx)),
            ],
          ),
        );
      },
    );
  }

  Widget _diyAppBar(BuildContext ctx) {
    return Container(
      height: ScreenUtil().setHeight(100),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      color: Color.fromRGBO(244, 246, 249, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _screenBar(ctx),
          _searchWidget(),
        ],
      ),
    );
  }

  /// 切换按钮
  Widget _screenBar(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(130),
              height: ScreenUtil().setHeight(30),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(60)),
              child: SwitchListButton(
                controller: ctx.read<SelectFilePageProvider>().mPageController,
                index: 0,
              ),
            ),
          ),
        ),
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
    );
  }

  /// 搜索
  Widget _searchWidget() {
    return Container(
      width: ScreenUtil().setWidth(330),
      height: ScreenUtil().setHeight(40),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
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

  Widget _pageView(BuildContext ctx) {
    List<FileModelUtil> fileList = ctx.watch<SelectFilePageProvider>().fileList;
    return PageView.builder(
      itemCount: 2,
      controller: ctx.read<SelectFilePageProvider>().mPageController,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext ctx, int index) {
        return index == 0
            ? AllFilePage(fileList: fileList)
            : ClassifyFilePage(fileList: fileList);
      },
    );
  }
}
