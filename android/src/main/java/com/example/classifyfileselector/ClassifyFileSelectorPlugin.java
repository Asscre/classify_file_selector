package com.example.classifyfileselector;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
/**
 * ClassifyFileSelectorPlugin
 */
public class ClassifyFileSelectorPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private static PluginRegistry.Registrar registrarFlutter;
    private static Context context;
    private static String TAG = "原生打印";
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "classify_file_selector");
        channel.setMethodCallHandler(this);
    }

    //此静态功能是可选的，相当于onAttachedToEngine。它支持老人

    //pre-Flutter-1.12 Android项目。我们鼓励你继续支持

    //当应用程序迁移到使用新的Android api时，通过此功能进行插件注册 onAttachedToEngine
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        // 先保存Registrar对象
        ClassifyFileSelectorPlugin.registrarFlutter = registrar;
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "classify_file_selector");
        channel.setMethodCallHandler(new ClassifyFileSelectorPlugin());
    }

    /**
     * todo: 和Fluttter端交互的通道
     *
     * @param call   从flutter接收
     * @param result 返回flutter
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Log.d("安卓原生端接收参数：", call.arguments.toString());
        switch (call.method){
            case comm.GET_FILE:
                // 接收的参数
                List<String> type = call.argument(comm.TYPE);
                // 返回的参数
                List<FileModel> fileModelList = new ArrayList<>();
                try {
                    // 得到对应类型文件  type.toArray(new String[type.size()])转换类型
                    List<String> list = FileUtilFlutter.getTypeOfFile(context, type);
                    for (String item : list) {
                        File f = new File(item);
                        FileModel fileModel = new FileModel();
                        fileModel.setFileName(f.getName());
                        fileModel.setFileSize(f.length());
                        fileModel.setFileDate(f.lastModified());
                        fileModel.setFilePath(f.getAbsolutePath());
                        fileModelList.add(fileModel);
                    }
                } finally {
                    // 返回给flutter
                    result.success(new Gson().toJson(fileModelList));
                }
                break;
            case comm.GET_BMP:
                result.success("999");
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

}
