import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            let facetecChannel = FlutterMethodChannel(name:"com.bankfab.nhl", binaryMessenger: controller.binaryMessenger)
            facetecChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                debugPrint("livenessCheck \(call.method)")
                if let viewcontroller = controller.storyboard?.instantiateViewController(withIdentifier: "FacetecBaseViewController") as? FacetecBaseViewController {
                    viewcontroller.result = result
                    controller.present(viewcontroller, animated: true) {
                        print("presented")
                    }
                } else {
                    result(false)
                }
                
                // show the screen here
                      // Note: this method is invoked on the UI thread.
                      // Handle battery messages.
            })
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
