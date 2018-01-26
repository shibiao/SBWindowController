# SBWindowController

SBWindowController可以使任意自定义高度TitleBar中的系统左上角3个按钮居中显示,还原纯原生close、mini、zoom按钮

使用方法：拖拽SBWindowController.swift文件进项目中，然后将继承于SBWindowController.swift与窗口控制器相关联，如下所示

```
import Cocoa

class MainWindowController: SBWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
    }

}
```

![1](https://github.com/shibiao/SBWindowController/blob/master/WX20180126-103536.png)
