package com.example.classifyfileselector;
import android.graphics.Bitmap;
import android.media.MediaMetadataRetriever;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;

/**
 * todo: 视频工具类
 * time: 2021-01-22 09:45:45
 * author: zwb
 */
public class VideolUtils {

    /**
     * todo: 保存内存中的bitmap到本地文件
     * @param bitmap 图片
     * @param localPath 路径
     * @param quality 质量
     * @param compressFormat 保存的格式
     */
    public static void saveBitmapToFile(Bitmap bitmap, String localPath, Integer quality, Bitmap.CompressFormat compressFormat){
        if (bitmap == null) {
            return;
        }
        try {
            File file = new File(localPath);
            FileOutputStream fos = new FileOutputStream(file);
            assert bitmap != null;
            bitmap.compress(compressFormat != null ? compressFormat : Bitmap.CompressFormat.JPEG , quality != null ? quality : 100, fos);//100表示正常质量，如果压缩之类的更改压缩质量即可
            fos.flush();
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * todo：获取视频媒体的缩略图
     * @param path 路径
     */
    public static Bitmap getVideoBitbmp(String path) {
        MediaMetadataRetriever media = new MediaMetadataRetriever();
        media.setDataSource(path);
        Bitmap bitmap = media.getFrameAtTime();
        // 释放Bitmap
        bitmap.recycle();
        return bitmap;
    }

//    /**
//     * todo：获取缩略图, 需引入依赖
//     *     api 'com.github.wseemann:FFmpegMediaMetadataRetriever-armeabi:1.0.14'
//     *     api 'com.github.wseemann:FFmpegMediaMetadataRetriever-armeabi-v7a:1.0.14'
//     *     api 'com.github.wseemann:FFmpegMediaMetadataRetriever-x86_64:1.0.14'
//     * @param mUri
//     */
//      public static void getImage(String mUri) {
//        //new出对象
//        FFmpegMediaMetadataRetriever mmr = new FFmpegMediaMetadataRetriever();
//
//        //设置数据源
//        mmr.setDataSource(mUri);
//
//        //获取媒体文件的专辑标题
//        mmr.extractMetadata(FFmpegMediaMetadataRetriever.METADATA_KEY_ALBUM);
//
//        //获取媒体文件的专辑艺术家
//        mmr.extractMetadata(FFmpegMediaMetadataRetriever.METADATA_KEY_ARTIST);
//
//        //获取2秒处的一帧图片（这里的2000000是微秒！！！）
//        Bitmap b = mmr.getFrameAtTime(2000000, FFmpegMediaMetadataRetriever.OPTION_CLOSEST);
//
//        //释放资源
//        mmr.release();
//    }
}
