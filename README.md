# DailyWorkTime

DailyWorkTime 是一个轻量的 macOS 工作时长记录工具，用来记录每天的开始/结束时间、自动统计工作时长，并通过分享码和朋友比较当天的工作时长。

界面风格偏 Apple 浅色系统，数据默认保存在本机，不需要注册账号或服务器。

当前版本：`1.4`

## 功能

- 记录每天多个工作时段
- 点击按钮记录当前系统时间
- 手动输入 `HHMM` 自动转换为 `HH:MM`
- 最后一行未填写结束时间时，自动按当前时间计算进行中的时长
- 跨天后自动以当天 `23:59` 结束计时
- 自动统计每段时长和当天总时长
- 设置两个每日工作目标
- 显示当前进度和目标完成比例
- 支持自定义自己和对比对象的名称
- 通过分享码导入朋友当天记录
- 支持 Apple 芯片和 Intel 芯片 Mac
- Intel 与 Apple 芯片使用一致的窗口拖动方式和应用图标

## 下载与使用

当前可直接使用的 macOS 安装包：

```text
DailyWorkTime-macOS.zip
```

使用方式：

1. 下载并解压 `DailyWorkTime-macOS.zip`
2. 打开 `DailyWorkTime.app`
3. 如果 macOS 第一次提示无法打开，可以右键 App，选择“打开”

## 分享码

DailyWorkTime 没有账号系统，也不会把数据上传到服务器。

如果想和朋友比较当天工作时长：

1. 点击“生成分享码”
2. 把生成的分享码发给对方
3. 对方复制分享码后点击“导入对方”

导入后，App 会显示两个人当天工作时长的对比。

## 本地数据

记录数据保存在当前电脑本地。删除浏览器/WebView 本地数据或更换电脑后，原数据不会自动同步。

## 项目结构

```text
.
├── index.html                  # 应用界面和主要逻辑
├── AppSource/
│   └── WorkTimeApp.swift        # macOS WebView 外壳
├── Assets/
│   └── DailyWorkTime-icon.png   # App 图标
└── DailyWorkTime-macOS.zip      # 可直接分发的 macOS 包
```

## 开发状态

这是一个个人小工具项目，目前以本地使用和轻量分享为主。

后续可能加入：

- 更清晰的历史统计
- 周/月视图
- 更方便的分享方式
- 云同步或账号系统

## License

This project is open-sourced under the MIT License. See `LICENSE` for details.
