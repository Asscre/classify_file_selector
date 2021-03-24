import 'dart:io';

/// file model
class FileModelUtil {
  File file;
  String fileName;
  int fileSize;
  String filePath;
  int fileDate;
  String fileSizeStr;
  String fileDateStr;
  String fileImage;
  String videoImg;
  FileModelUtil({
    this.fileDate,
    this.fileName,
    this.filePath,
    this.fileSize,
    this.file,
    this.fileDateStr,
    this.fileImage,
    this.fileSizeStr,
    this.videoImg,
  });
}
