import Cocoa
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate, WKUIDelegate, WKScriptMessageHandlerWithReply {
    private var window: NSWindow!
    private var webView: WKWebView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        configureMainMenu()

        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        let userContentController = WKUserContentController()
        userContentController.addScriptMessageHandler(self, contentWorld: .page, name: "clipboard")
        configuration.userContentController = userContentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1180, height: 780),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "DailyWorkTime"
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = false
        window.minSize = NSSize(width: 760, height: 560)
        window.center()
        window.contentView = webView
        window.makeKeyAndOrderFront(nil)

        loadInterface()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage,
        replyHandler: @escaping (Any?, String?) -> Void
    ) {
        let text = NSPasteboard.general.string(forType: .string) ?? ""
        replyHandler(text, nil)
    }

    private func configureMainMenu() {
        let mainMenu = NSMenu()
        let appMenuItem = NSMenuItem()
        let editMenuItem = NSMenuItem()

        mainMenu.addItem(appMenuItem)
        mainMenu.addItem(editMenuItem)

        let appMenu = NSMenu(title: "DailyWorkTime")
        appMenu.addItem(withTitle: "退出 DailyWorkTime", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appMenuItem.submenu = appMenu

        let editMenu = NSMenu(title: "编辑")
        editMenu.addItem(withTitle: "撤销", action: Selector(("undo:")), keyEquivalent: "z")
        editMenu.addItem(withTitle: "重做", action: Selector(("redo:")), keyEquivalent: "Z")
        editMenu.addItem(NSMenuItem.separator())
        editMenu.addItem(withTitle: "剪切", action: #selector(NSText.cut(_:)), keyEquivalent: "x")
        editMenu.addItem(withTitle: "复制", action: #selector(NSText.copy(_:)), keyEquivalent: "c")
        editMenu.addItem(withTitle: "粘贴", action: #selector(NSText.paste(_:)), keyEquivalent: "v")
        editMenu.addItem(withTitle: "全选", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a")
        editMenuItem.submenu = editMenu

        NSApp.mainMenu = mainMenu
    }

    private func loadInterface() {
        guard let url = Bundle.main.url(forResource: "index", withExtension: "html") else {
            showMissingFileMessage()
            return
        }

        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }

    private func showMissingFileMessage() {
        let alert = NSAlert()
        alert.messageText = "没有找到应用界面文件"
        alert.informativeText = "请确认 index.html 已经放在应用资源文件夹中。"
        alert.alertStyle = .warning
        alert.runModal()
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.activate(ignoringOtherApps: true)
app.run()
