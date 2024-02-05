import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("GOOGLE MAPS API HERE HERE")
    GeneratedPluginRegistrant.register(with: self)

    let factory = FLNativeViewFactory()
    self.registrar(forPlugin: "testViewPlugin")!.register(
        factory,
        withId: "testView")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
