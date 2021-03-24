import 'package:flutter/material.dart';
import 'package:classify_file_selector/model/file_util_model.dart';
import 'package:classify_file_selector/classify_file_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FileModelUtil> v;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClassifyFileSelector"),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClassifyFileSelector(
              btn: Container(
                height: 40,
                width: 120,
                color: Colors.amberAccent,
                alignment: Alignment.center,
                child: Text("选择文件"),
              ),
              maxCount: 3,
              fileTypeEnd: [
                ".mp4",
                ".mp3",
                ".flac"
                ".pdf",
                ".doc",
                ".docx",
                ".xls",
                ".xlsx",
                ".pptx",
                ".ppt",
              ],
              valueChanged: (v) {
                print(v[0].filePath);
                this.v = v;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
