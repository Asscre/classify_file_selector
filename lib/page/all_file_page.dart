import 'package:classify_file_selector/page/comm/image_widget.dart';
import 'package:classify_file_selector/page/comm/video_widget.dart';
import 'package:classify_file_selector/provider/classify_file_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:classify_file_selector/comm/comm.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:provider/provider.dart';

class AllFilePage extends StatefulWidget {
  final List<FileModelUtil> fileList;

  const AllFilePage({Key key, @required this.fileList}) : super(key: key);

  @override
  _AllFilePageState createState() => _AllFilePageState();
}

class _AllFilePageState extends State<AllFilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    int len = widget.fileList.length;
    return len == 0
        ? _loadingWidget(context)
        : ListView.builder(
            itemCount: len,
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, int index) {
              return FileListItemWidget(
                val: widget.fileList[index],
                index: index,
              );
            },
          );
  }

  /// 加载视图loading
  Widget _loadingWidget(BuildContext ctx) {
    bool loading = ctx.watch<ClassifyFilePageProvider>().loading;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loading
            ? CircularProgressIndicator(
                strokeWidth: 6.0,
                backgroundColor: Colors.grey[400],
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black45),
              )
            : SizedBox(),
        Text(
          loading ? "加载中" : "没有文件~",
          style: TextStyle(height: 1.5),
        )
      ],
    );
  }
}

class FileListItemWidget extends StatelessWidget {
  final FileModelUtil val;
  final int index;
  const FileListItemWidget({Key key, @required this.val, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    print(val.fileImage);
    return CheckboxListTile(
      value: ctx.read<ClassifyFilePageProvider>().check(index, 1),
      onChanged: (bool value) =>
          ctx.read<ClassifyFilePageProvider>().selectFile(index, 1),
      secondary: _show(),
      title: Text(
        "${val.fileName}",
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            val.fileDateStr,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.grey[400]),
          ),
          Text(
            " ${val.fileSizeStr} MB",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.grey[400]),
          ),
        ],
      ),
      dense: false,
      activeColor: Colors.blue[400],
      // 指定选中时勾选框的颜色
      checkColor: Colors.white,
      isThreeLine: false,
      selected: ctx.read<ClassifyFilePageProvider>().check(index, 1),
    );
  }

  Widget _show() {
    final w = ScreenUtil().setWidth(40);
    final h = ScreenUtil().setWidth(40);
    print(val.videoImg);
    switch (val.fileImage) {
      case 'images/video.png':
        return VideoWidget(val, width: w, height: h);
        break;
      case 'images/image.png':
        return ImageWidget(val, width: w, height: h);
        break;
      default:
        return Image.asset(
          val.fileImage,
          package: Comm.PACKNAME,
          width: w,
          height: h,
        );
    }
  }
}
