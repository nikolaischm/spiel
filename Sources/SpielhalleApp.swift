import SwiftUI
import WebKit

@main
struct SpielhalleApp: App {
    var body: some Scene {
        WindowGroup {
            SpielhalleView()
                .ignoresSafeArea()
                .background(Color(red: 0, green: 0.5, blue: 0.5))
                .statusBarHidden(true)
                .persistentSystemOverlays(.hidden)
        }
    }
}

/// Zeigt die Spielhalle (spielhalle.html aus der App) in einer Web-Ansicht.
/// Gleicher Code wie Spielhalle.exe und die Website – daher dieselben Räume.
struct SpielhalleView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()          // Name + Raum werden gespeichert
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let web = WKWebView(frame: .zero, configuration: config)
        let teal = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        web.isOpaque = false
        web.backgroundColor = teal
        web.scrollView.backgroundColor = teal
        web.scrollView.bounces = false
        web.scrollView.contentInsetAdjustmentBehavior = .never
        web.allowsLinkPreview = false
        if #available(iOS 16.4, *) { web.isInspectable = true }

        if let url = Bundle.main.url(forResource: "spielhalle", withExtension: "html") {
            web.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        return web
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
