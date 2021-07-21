import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let factory = FLNativeViewFactory()
    self.registrar(forPlugin: "testViewPlugin")!.register(
        factory,
        withId: "testView")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
