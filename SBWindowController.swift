//
//  SBWindowController.swift
//  Mac_test
//
//  Created by 石彪 on 2018/1/26.
//  Copyright © 2018年 石彪. All rights reserved.
//
/*
 SBWindowController
 
 SBWindowController可以使任意自定义高度TitleBar中的系统左上角3个按钮居中显示,还原纯原生close、mini、zoom按钮
 
 使用方法：拖拽SBWindowController.swift文件进项目中，然后将继承于SBWindowController.swift与窗口控制器相关联，如下所示
 
 import Cocoa
 
 class MainWindowController: SBWindowController {
 
     override func windowDidLoad() {
     super.windowDidLoad()
 
     }
 
 }
 
*/

import Cocoa

class SBWindowController: NSWindowController {
    //此处设置TitleBarHeight
    let kTitlebarHeight: CGFloat = 54.0
    //调节button按钮初始x轴坐标
    var buttonOriginX: CGFloat = 12.0
    //三个按钮数字
    var buttons: [NSButton]!
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.delegate = self
        updateTitleBarOfWindow(window: window!, fullScreen: false)
        buttons = [
            (window?.standardWindowButton(.closeButton))!,
            (window?.standardWindowButton(.miniaturizeButton))!,
            (window?.standardWindowButton(.zoomButton))!
        ]
    }
    func updateTitleBarOfWindow(window: NSWindow ,fullScreen: Bool) {
        let kFullScreenButtonYOrigin: CGFloat = 3.0
        let windowFrame = window.frame
        let titlebarContainerView = window.standardWindowButton(.closeButton)?.superview?.superview;
        var titlebarContainerFrame = titlebarContainerView?.frame
        titlebarContainerFrame?.origin.y = windowFrame.size.height - kTitlebarHeight
        titlebarContainerFrame?.size.height = CGFloat(kTitlebarHeight)
        titlebarContainerView?.frame = titlebarContainerFrame!
        
        var buttonX:CGFloat = buttonOriginX
        let closeButton = window.standardWindowButton(.closeButton)
        let minimizeButton = window.standardWindowButton(.miniaturizeButton)
        let zoomButton = window.standardWindowButton(.zoomButton)
        
        for buttonView in [closeButton,minimizeButton,zoomButton] {
            var btnFrame = buttonView?.frame
            let f: CGFloat = round((kTitlebarHeight - (btnFrame?.size.height)!) / 2.0)
            btnFrame?.origin.y = fullScreen ? kFullScreenButtonYOrigin : f
            btnFrame?.origin.x = CGFloat(buttonX)
            buttonX = (btnFrame?.size.width)! + 6 + buttonX
            
            buttonView?.setFrameOrigin((btnFrame?.origin)!)
        }
    }

}
extension SBWindowController: NSWindowDelegate {
    func windowDidEnterFullScreen(_ notification: Notification) {
        updateTitleBarOfWindow(window: window!, fullScreen: true)
    }
    func windowWillExitFullScreen(_ notification: Notification) {
        _ = buttons.map{$0.isHidden = true}
    }
    func windowDidExitFullScreen(_ notification: Notification) {
        self.updateTitleBarOfWindow(window: self.window!, fullScreen: false)
        _ = buttons.map{$0.isHidden = false}
    }
    func windowDidResize(_ notification: Notification) {
        updateTitleBarOfWindow(window: window!, fullScreen: false)
    }
}
