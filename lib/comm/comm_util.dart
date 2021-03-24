import 'package:classify_file_selector/comm/style.dart';

abstract class CommUtil {
  // 常用音乐格式
  static const List<String> musicExpandName = [
    ".mp3",
    ".wav",
    ".ape",
    ".ogg",
    ".flac",
    ".flv"
  ];

  // 常用视频格式
  static const List<String> videoExpandName = [
    ".avi",
    ".mp4",
    ".rmvb",
    ".mov",
    ".rm",
    ".flv"
  ];

  // 常用压缩包格式
  static const List<String> rarExpandName = [
    ".zip",
    ".rar",
    ".iso",
    ".7z",
    ".gzip"
  ];

  // 常用图片格式
  static const List<String> imgExpandName = [
    ".bmp",
    ".jpg",
    ".png",
    ".gif",
    ".svg",
    ".webp",
    ".jpeg"
  ];

  // 常用Office格式
  static const List<String> officeExpandName = [
    ".pdf",
    ".doc",
    ".docx",
    ".xls",
    ".xlsx"
  ];

  static fileLogo(String str) {
    str = str.toLowerCase();
    Map m = Map();

    if (str.endsWith(".pdf")) {
      m["png"] = Style.IMG_PDF;
      return m;
    }
    if (str.endsWith(".ppt") || str.endsWith(".pptx")) {
      m["png"] = Style.IMG_PPT;
      return m;
    }
    if (str.endsWith(".doc") || str.endsWith(".docx")) {
      m["png"] = Style.IMG_WORD;
      return m;
    }
    if (str.endsWith(".xlsx") || str.endsWith(".xls")) {
      m["png"] = Style.IMG_EXCEL;
      return m;
    }
    if (str.endsWith(".txt")) {
      m["png"] = Style.IMG_TXT;
      return m;
    }

    for (int i = 0; i < musicExpandName.length; i++) {
      if (str.endsWith(musicExpandName[i])) {
        m["png"] = Style.IMG_MUSIC;
        return m;
      }
    }

    for (int i = 0; i < videoExpandName.length; i++) {
      if (str.endsWith(videoExpandName[i])) {
        m["png"] = "images/video.png";
        return m;
      }
    }

    for (int i = 0; i < rarExpandName.length; i++) {
      if (str.endsWith(rarExpandName[i])) {
        m["png"] = "images/ys.png";
        return m;
      }
    }

    for (int i = 0; i < imgExpandName.length; i++) {
      if (str.endsWith(imgExpandName[i])) {
        m["png"] = "images/image.png";
        return m;
      }
    }
    m["png"] = "images/out.png";
    return m;
  }
}
