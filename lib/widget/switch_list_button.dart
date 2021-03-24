import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';

class SwitchListButton extends StatelessWidget {
  final PageController controller;
  final int index;

  SwitchListButton({Key key, @required this.controller, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color _blue = Color.fromRGBO(81, 182, 239, 1);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
        border: Border.all(color: _blue),
      ),
      child: ChangeNotifierProvider(
          create: (_) => SwitchListButtonProvider(controller, index),
          builder: (BuildContext ctx, Widget child) {
            bool _is = ctx.watch<SwitchListButtonProvider>().currentIndex == 0;
            return Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: !_is
                        ? MaterialStateProperty.all(Colors.white)
                        : MaterialStateProperty.all(_blue),
                  ),
                  onPressed: () =>
                      ctx.read<SwitchListButtonProvider>().sfunc(0, ctx),
                  child: Text(
                    '最近',
                    style: TextStyle(
                      color: _is ? Colors.white : _blue,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: _is
                        ? MaterialStateProperty.all(Colors.white)
                        : MaterialStateProperty.all(_blue),
                  ),
                  onPressed: () =>
                      ctx.read<SwitchListButtonProvider>().sfunc(1, ctx),
                  child: Text(
                    '全部',
                    style: TextStyle(
                      color: !_is ? Colors.white : _blue,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class SwitchListButtonProvider with ChangeNotifier {
  int currentIndex;

  PageController controller;

  bool isFirst = false;

  SwitchListButtonProvider(PageController c, int index) {
    currentIndex = index;
    controller = c;
  }

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
    if (controller != null) {
      controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void sfunc(int i, BuildContext ctx) {
    if (currentIndex != i) {
      currentIndex = i;
      changePage(currentIndex);
    }
     // if(i == 1 && !isFirst) {
     //   ctx
     //       .read<SelectFilePageProvider>()
     //       .screenFile(CommUtil.imgExpanName);
     //   isFirst = true;
     // }
  }
}
