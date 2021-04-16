import 'package:classify_file_selector/page/comm/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:classify_file_selector/model/classify_file_item_model.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:classify_file_selector/page/all_file_page.dart';
import 'package:classify_file_selector/provider/classify_file_page_provider.dart';
import 'package:provider/provider.dart';

import 'comm/image_widget.dart';

class ClassifyFilePage extends StatefulWidget {
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _classifyBar(context),
          _content(context),
        ],
      ),
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
        ImageWidget(val),
      ],
    );
  }

  Widget _videoWidget(FileModelUtil val) {
    return Stack(
      children: [
        VideoWidget(val),
      ],
    );
  }

  Widget _otherWidget(List<FileModelUtil> fileList) {
    return AllFilePage(fileList: fileList);
  }
}
