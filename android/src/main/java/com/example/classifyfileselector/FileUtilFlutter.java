package com.example.flutterfileselector;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore.Files;
import android.provider.MediaStore.Files.FileColumns;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class FileUtilFlutter {
    private static ContentResolver mContentResolver;
    public static List<String> getTypeOfFile(Context context, List<String> extension)
    {
        mContentResolver = context.getContentResolver();
        List<String> list = new ArrayList<>();

        //从外存中获取
        Uri fileUri=Files.getContentUri("external");

        //筛选列，筛选 文件路径、不含后缀的文件名
        String[] projection = new String[]{
                FileColumns.DATA,
                FileColumns.TITLE ,
        };

        //筛选语句
        String selection="";

        for(int i=0;i<extension.size();i++)
        {
            if(i!=0)
            {
                selection=selection+" OR ";
            }
            selection=selection+FileColumns.DATA+" LIKE '%"+extension.get(i)+"'";
        }

        //按时间递增顺序进行排序，从后往前移动游标就可实现时间递减
        String sortOrder=FileColumns.DATE_MODIFIED;

        //获取内容解析器对象
        ContentResolver resolver=context.getContentResolver();

        //查到游标
        Cursor cursor=resolver.query(fileUri, projection, selection, null, sortOrder);

        if(cursor==null)
            return null;

        //游标从最后开始往前递减，实现时间递减顺序（最近访问的文件，优先显示）
        if(cursor.moveToLast())
        {
            do{

                //输出文件的完整路径
                String data=cursor.getString(0);

                list.add(data);

                Log.d("路径", data);

            }while(cursor.moveToPrevious());
        }

        cursor.close();
        return list;

    }
}
