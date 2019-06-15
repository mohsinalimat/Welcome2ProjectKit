//
//  Welcome2ProjectWindowController.swift
//  Welcome2ProjectKit
//
//  Created by Jovi on 6/10/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa

public class Welcome2ProjectWindowController: NSWindowController {
    private var _btnClose: NSButton?
    private var _ivLogo: NSImageView?
    private var _lbTitle: WPKLabel?
    private var _lbSubtitle: WPKLabel?
    private var _cbDisplayWhenLaunch: WPKCheckBox?
    private var _rightView: NSView?
    private var _leftView: WPKView?
    private var _tvProjectListTableView: NSTableView?
    private var _btnOpenProject: NSButton?
    private var _btn1: WPKButton?
    private var _btn2: WPKButton?
    private var _btn3: WPKButton?

    public init() {
        super.init(window: nil)
        _initializeWelcome2ProjectWindowController()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Private functions
extension Welcome2ProjectWindowController {

    // swiftlint:disable function_body_length
    private func _initializeWelcome2ProjectWindowController() {
        let rectWnd = NSRect(x: 0, y: 0, width: 802, height: 472)
        let rctRightView = NSRect(x: 495, y: 0, width: 307, height: 472)
        self.window = NSWindow.init(contentRect: rectWnd,
                                    styleMask: [.fullSizeContentView, .titled],
                                    backing: .buffered,
                                    defer: true)

        if let wnd = self.window {
            wnd.titlebarAppearsTransparent = true
            wnd.backgroundColor = NSColor.white
            wnd.isMovableByWindowBackground = true

            let leftview = WPKView.init(frame: NSRect(x: 0, y: 0, width: 495, height: 472))
            wnd.contentView?.addSubview(leftview)
            _leftView = leftview

            let btnClose = NSButton.init(frame: NSRect(x: 10, y: rectWnd.height - 16, width: 8, height: 8))
            btnClose.image = NSImage.init(named: "NSStopProgressTemplate")
            btnClose.bezelStyle = .regularSquare
            btnClose.imagePosition = .imageOnly
            btnClose.isBordered = false
            btnClose.focusRingType = .none
            btnClose.setButtonType(.pushOnPushOff)
            btnClose.target = self
            btnClose.action = #selector(closeBtn_click(_:))
            _leftView?.addSubview(btnClose)
            _btnClose = btnClose

            var offsetX = (rectWnd.width - rctRightView.width - 128) / 2
            var offsetY = rectWnd.height - 168
            let ivLogo = NSImageView.init(frame: NSRect(x: offsetX, y: offsetY, width: 128, height: 128))
            ivLogo.image = NSImage.init(named: "Xcode")
            ivLogo.imageScaling = .scaleAxesIndependently
            _leftView?.addSubview(ivLogo)
            _ivLogo = ivLogo

            offsetX = 0
            offsetY = ivLogo.frame.minY - 50
            let lbTitle = WPKLabel.init(frame: NSRect(x: offsetX,
                                                      y: offsetY,
                                                      width: rectWnd.width - rctRightView.width,
                                                      height: 48))
            lbTitle.stringValue = "Welcome to Xcode"
            lbTitle.alignment = .center
            lbTitle.font = NSFont.init(name: "Helvetica Neue Thin", size: 40)
            _leftView?.addSubview(lbTitle)
            _lbTitle = lbTitle

            offsetX = 0
            offsetY = lbTitle.frame.minY - 23
            let lbSubtitle = WPKLabel.init(frame: NSRect(x: offsetX,
                                                      y: offsetY,
                                                      width: rectWnd.width - rctRightView.width,
                                                      height: 15))
            lbSubtitle.stringValue = "Version 10.2 (10E125)"
            lbSubtitle.alignment = .center
            lbSubtitle.font = NSFont.init(name: "Helvetica Neue Light", size: 13)
            lbSubtitle.textColor = NSColor(hex: "808080", alpha: 1)
            _leftView?.addSubview(lbSubtitle)
            _lbSubtitle = lbSubtitle

            let btn3 = WPKButton.init(frame: NSRect(x: 62, y: 58, width: 431, height: 47))
            btn3.image = NSImage.init(named: "NewCheckoutTemplate")
            btn3.lbTitle.stringValue = "Clone an existing project"
            btn3.lbSubTitle.stringValue = "Start working on something on Gir repository."
            _leftView?.addSubview(btn3)
            _btn3 = btn3

            let btn2 = WPKButton.init(frame: NSRect(x: 62, y: btn3.frame.maxY, width: 431, height: 47))
            btn2.image = NSImage.init(named: "NewProjectTemplate")
            btn2.lbTitle.stringValue = "Create a new Xcode project"
            btn2.lbSubTitle.stringValue = "Create an app for iPhone, iPad, Mac, Apple Watch, or Apple TV."
            _leftView?.addSubview(btn2)
            _btn2 = btn2

            let btn1 = WPKButton.init(frame: NSRect(x: 62, y: btn2.frame.maxY, width: 431, height: 47))
            btn1.image = NSImage.init(named: "NewPlaygroundTemplate")
            btn1.lbTitle.stringValue = "Get started with a playground"
            btn1.lbSubTitle.stringValue = "Explore new ideas quickly and easily."
            _leftView?.addSubview(btn1)
            _btn1 = btn1

            offsetX = 70
            offsetY = 7
            let cbDisplayWhenLaunch = WPKCheckBox.init(frame: NSRect(x: offsetX,
                                                      y: offsetY,
                                                      width: 250,
                                                      height: 16))
            cbDisplayWhenLaunch.state = .on
            cbDisplayWhenLaunch.title = "     Show this window when Xcode launches"
            cbDisplayWhenLaunch.isHidden = true
            _leftView?.addSubview(cbDisplayWhenLaunch)
            _cbDisplayWhenLaunch = cbDisplayWhenLaunch
            _leftView?.mouseEnteredCallback = { (event) in
                cbDisplayWhenLaunch.animator().isHidden = false
            }
            _leftView?.mouseExitedCallback = { (event) in
                cbDisplayWhenLaunch.animator().isHidden = true
            }

            let rightView = NSVisualEffectView.init(frame: rctRightView)
            rightView.wantsLayer = true
            wnd.contentView?.addSubview(rightView)
            _rightView = rightView

            let btnOpenProject = NSButton.init(frame: NSRect(x: 8, y: 1, width: 180, height: 20))
            btnOpenProject.bezelStyle = .recessed
            btnOpenProject.title = "Open another project..."
            btnOpenProject.font = NSFont.init(name: "Helvetica Neue Light", size: 13)
            btnOpenProject.focusRingType = .none
            btnOpenProject.setButtonType(.momentaryChange)
            btnOpenProject.state = .off
            btnOpenProject.showsBorderOnlyWhileMouseInside = true
            btnOpenProject.alignment = .left
            btnOpenProject.target = self
            btnOpenProject.action = #selector(openOtherProjectBtn_click(_:))
            _rightView?.addSubview(btnOpenProject)
            _btnOpenProject = btnOpenProject

            let scrollView = NSScrollView.init(frame: NSRect(x: 0,
                                                             y: 22,
                                                             width: rctRightView.width,
                                                             height: rctRightView.height - 22))
            scrollView.drawsBackground = false
            _rightView?.addSubview(scrollView)

            let tableView = NSTableView.init(frame: scrollView.bounds.insetBy(dx: 1, dy: 1))
            tableView.headerView = nil
            tableView.rowSizeStyle = .large
            tableView.delegate = self
            tableView.dataSource = self
            _tvProjectListTableView = tableView
            scrollView.documentView = tableView

            let column1 = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier.init("column1"))
            tableView.addTableColumn(column1)
            tableView.sizeLastColumnToFit()
            tableView.selectionHighlightStyle = .sourceList
            tableView.floatsGroupRows = false
        }
    }
}

// MARK: Delegate and Data Source
extension Welcome2ProjectWindowController: NSTableViewDelegate, NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }

    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cellView"), owner: self)
        if nil == view {
            let cellView = WPKTableCellView.init()
            if let img = NSImage.init(named: "project") {
                cellView.updateUI(img: img, title: "XUIKit", subtitle: "Work Space/XUIKit")
            }
            cellView.identifier = NSUserInterfaceItemIdentifier(rawValue: "cellView")
            view = cellView
        }
        return view
    }

    public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let itemHeight: CGFloat = 43
        return itemHeight
    }

}

// MARK: Actions
extension Welcome2ProjectWindowController {

    @objc func closeBtn_click(_ :Any?) {
        self.close()
    }

    @objc func openOtherProjectBtn_click(_ :Any?) {
    }
}