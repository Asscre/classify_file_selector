import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:classify_file_selector/model/classify_file_item_model.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:classify_file_selector/page/all_file_page.dart';
import 'package:classify_file_selector/provider/classify_file_page_provider.dart';
import 'package:provider/provider.dart';

class ClassifyFilePage extends StatefulWidget {
  final List<FileModelUtil> fileList;

  const ClassifyFilePage({Key key, this.fileList}) : super(key: key);

  @override
  _ClassifyFilePageState createState() => _ClassifyFilePageState();
}

class _ClassifyFilePageState extends State<ClassifyFilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClassifyFilePageProvider(),
      builder: (BuildContext ctx, Widget child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _classifyBar(ctx),
              _content(ctx),
            ],
          ),
        );
      },
    );
  }

  Widget _classifyBar(BuildContext ctx) {
    List<Widget> _lw = [];
    List<ClassifyFileItemModel> _classilyBarList =
        ctx.watch<ClassifyFilePageProvider>().classifyBarList;
    for (int i = 0; i < 5; i++) {
      _lw.add(_classifyBarItem(_classilyBarList[i], i, ctx));
      if (i < 4) {
        _lw.add(SizedBox(
          width: ScreenUtil().setWidth(10),
        ));
      }
    }

    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _lw,
      ),
    );
  }

  Widget _classifyBarItem(ClassifyFileItemModel val, int i, BuildContext ctx) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            ctx.read<ClassifyFilePageProvider>().switchClassily(i, ctx),
        child: Container(
          height: ScreenUtil().setHeight(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(50)),
            color:
                val.isSelect ? Color.fromRGBO(244, 246, 249, 1) : Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            val.name,
            style: TextStyle(
              color: Color.fromRGBO(183, 185, 195, 1),
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext ctx) {
    List<Widget> _lw = [
      _imageWidget(ctx.watch<ClassifyFilePageProvider>().imgFileList),
      _videoWidget(ctx.watch<ClassifyFilePageProvider>().videoFileList),
      _otherWidget(ctx.watch<ClassifyFilePageProvider>().musicFileList),
      _otherWidget(ctx.watch<ClassifyFilePageProvider>().officeFileList),
      _otherWidget(ctx.watch<ClassifyFilePageProvider>().rarFileList),
    ];
    return Expanded(
      child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: ctx.read<ClassifyFilePageProvider>().pageController,
          itemCount: 5,
          itemBuilder: (BuildContext ctx, int i) {
            return _lw[i];
          },
      ),
    );
  }

  Widget _imageWidget(List<FileModelUtil> fileList) {

    List<FileModelUtil> _val = [];

    fileList.forEach((e) {
      if (_val.indexWhere((item) => e.filePath == item.filePath) == -1) {
        _val.add(e);
      }
    });

    List<Widget> _lw = [];
    _val.forEach((e) {
      _lw.add(Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 246, 249, 1),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
            ),
            child: Image.file(
              e.file,
              fit: BoxFit.cover,
              width: ScreenUtil().setWidth(110),
              height: ScreenUtil().setWidth(110),
            ),
          ),
        ],
      ));
    });
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: ScreenUtil().setWidth(5),
        crossAxisSpacing: ScreenUtil().setWidth(5),
        crossAxisCount: 4,
        childAspectRatio: 1.0,
      ),
      children: _lw,
    );
  }

  Widget _videoWidget(List<FileModelUtil> fileList) {
    List<FileModelUtil> _val = [];

    fileList.forEach((e) {
      if (_val.indexWhere((item) => e.fileName == item.fileName) == -1) {
        _val.add(e);
      }
    });

    List<Widget> _lw = [];
    _val.forEach((e) async {
      _lw.add(Stack(
        children: [
          Container(
            height: ScreenUtil().setWidth(180),
            width: ScreenUtil().setWidth(180),
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 246, 249, 1),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
            ),
            // child: Text(e.fileName),
            child: Image.file(
              File(e.videoImg),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ));
    });
    return GridView(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: ScreenUtil().setWidth(5),
          crossAxisSpacing: ScreenUtil().setWidth(5),
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        children: _lw,
    );
  }

  /// music office and other file widget
  Widget _otherWidget(List<FileModelUtil> fileList) {
    return AllFilePage(fileList: fileList);
  }
}

