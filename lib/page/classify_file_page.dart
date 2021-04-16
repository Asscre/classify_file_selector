import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:classify_file_selector/model/classify_file_item_model.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:classify_file_selector/page/all_file_page.dart';
import 'package:classify_file_selector/provider/classify_file_page_provider.dart';
import 'package:provider/provider.dart';

class ClassifyFilePage extends StatefulWidget {
  final ClassifyFilePageProvider p;

  const ClassifyFilePage({Key key, this.p}) : super(key: key);

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
    return ChangeNotifierProvider.value(
      value: widget.p,
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
            ctx.read<ClassifyFilePageProvider>().switchClassify(i, ctx),
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
      _imgAndVideoWidget(ctx.watch<ClassifyFilePageProvider>().imgFileList, 0),
      _imgAndVideoWidget(
          ctx.watch<ClassifyFilePageProvider>().videoFileList, 1),
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

  Widget _imgAndVideoWidget(List<FileModelUtil> fileList, int type) {
    List<FileModelUtil> _val = [];

    fileList.forEach((e) {
      if (_val.indexWhere((item) =>
              e.filePath == item.filePath || e.fileName == item.fileName) ==
          -1) {
        _val.add(e);
      }
    });

    Widget _w(FileModelUtil val) {
      return type == 0 ? _imageWidget(val) : _videoWidget(val);
    }

    return Scrollbar(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: ScreenUtil().setWidth(5),
          crossAxisSpacing: ScreenUtil().setWidth(5),
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        itemCount: _val.length,
        itemBuilder: (BuildContext context, int index) {
          return _w(_val[index]);
        },
      ),
    );
  }

  Widget _imageWidget(FileModelUtil val) {
    return Stack(
      children: [
        Container(
          width: ScreenUtil().setWidth(170),
          height: ScreenUtil().setWidth(170),
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
        ),
      ],
    );
  }

  Widget _videoWidget(FileModelUtil val) {
    return Stack(
      children: [
        Container(
          height: ScreenUtil().setWidth(180),
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 246, 249, 1),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
          ),
          // child: Text(e.fileName),
          child: Image.memory(
            val.videoImg,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  /// music office and other file widget
  Widget _otherWidget(List<FileModelUtil> fileList) {
    return AllFilePage(fileList: fileList);
  }
}
