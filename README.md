# classify_file_selector

### 插件介绍：

> 使用中如有问题之类的话  欢迎来提 issues 
> Flutter版本的一个文件选择器 ，顺序按最近访问的时间排序

> 布局使用Flutter布局，安卓使用原生的MediaStore.Files类实现
>

> 支持多选，支持所有文件类型
>

<a href='https://github.com/Asscre/classify_file_selector'>apk下载体验 , ios暂无打包 自行拉取代码编译</a>

![安卓]<img src='/001.jpg' width='40%'/>
![安卓]<img src='/002.jpg' width='40%'/>
![安卓]<img src='/003.jpg' width='40%'/>
![ios]<img src='/ios1.png' width='40%'/>
![ios]<img src='/ios2.png' width='40%'/>

**使用到的插件**

|  插件依赖   | pub仓库地址  |
|  ----  | ----  |
| permission_handler  | <a href='https://pub.flutter-io.cn/packages/permission_handler'>pub</a>  |
| file_picker  | <a href='https://pub.flutter-io.cn/packages/file_picker'>pub</a>  |

### 示例：

```yaml
# 在pubspec.yaml 中引入依赖 方式1
classify_file_selector:
   git:
      url: https://github.com/Asscre/classify_file_selector

# 在pubspec.yaml 中引入依赖 方式2
classify_file_selector: ^0.0.1
```

```javascript
List<String> fileTypeEnd = [".pdf", ".doc", ".docx",".xls",".xlsx"];
// 显示筛选按钮
FlutterSelect(
    /// 按钮
    btn: Text("选择文档"),
    /// 最大可选
    maxCount: 9,
    /// 选择格式,默认是[".pdf", ".doc", ".docx",".xls",".xlsx"]
    fileTypeEnd: fileTypeEnd，
    valueChanged: (v){
        
    },
),

### 可选参数

|  参数名   | 值 |
|  ----  | ----  |
| List<String>  fileTypeEnd | 文件类型 -  默认：[".pdf", ".doc", ".docx",".xls",".xlsx"] |
| int maxCount  | 可选最大总数 -  默认 9 |

### 返回的参数：

|  参数名   | 值 |
|  ----  | ----  |
| File file  | 文件 |
| String fileName  | 文件名称 |
| int fileSize | 文件大小 |
| String filePath  | 文件路径 |
| int fileDate  | 文件日期时间 |

### 计划-待实现：

[] 实现Android端
[] 实现IOS端
[] 实现搜索
[] 最近模块实现常用应用分类（微信、qq、其他）

### 注意：一定要有权限、必需配置

<h5>安卓需配置目录访问权限 配置AndroidManifest.xml 文件，application里加入如下代码</h5>

```
// tools:replace="android:resource"  需要导入tools 才能使用
// AndroidManifest.xml 的 manifest 中 引入 xmlns:tools="http://schemas.android.com/tools"
<provider
   android:name="androidx.core.content.FileProvider"
   android:authorities="${applicationId}.fileProvider"
   android:exported="false"
   android:grantUriPermissions="true"
   tools:replace="android:authorities">
   <meta-data
       android:name="android.support.FILE_PROVIDER_PATHS"
       android:resource="@xml/file_select_flutter"
       tools:replace="android:resource" />
</provider>
```
 

IOS 的配置 [点此查看]( https://github.com/miguelpruivo/flutter_file_picker/wiki/Setup#--ios)

### 更新日志：

#### 2020-06-07  

- 首个版本

- 优化了全部目录检索，并支持指定 自定义展示文件类型

#### 2020-06-09 
- 修复了部分设备无法运行
- 集成了权限检查
#### 2020-06-10 
- 兼容ios
- 修改了type解析
- 修复了部分bug
#### 2020-06-18
- 修改视图页延迟检索，先进入ui页面 避免卡死
- 添加参数 可选数量 `maxCount`
#### 2020-06-19
- 添加、更新了示例   example
- 文件类型选择 更改为 下拉选择
#### 2021-01-20
- 添加、修改了 图标
- 优化了代码，修复了ios问题
- 优化了 选择类型
- 选择类型、标题 可自定义
- 更新了文档
#### 2021-01-27
- 优化了部分逻辑
- 更新了默认选择
- 更改了 选择 按钮
