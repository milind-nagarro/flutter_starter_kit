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
                debugPrint("channel method \(call.method)")
                if call.method == "LivenessCheck" {
                    if let viewcontroller = controller.storyboard?.instantiateViewController(withIdentifier: "FacetecBaseViewController") as? FacetecBaseViewController {
                        viewcontroller.result = result
                        controller.present(viewcontroller, animated: true) {
                            debugPrint("presented facetec screen")
                        }
                    } else {
                        result(false)
                    }
                } else if call.method == "BlinkOCR" {
                    if let viewcontroller = controller.storyboard?.instantiateViewController(withIdentifier: "OCRViewController") as? OCRViewController {
                        viewcontroller.result = result
                        controller.present(viewcontroller, animated: false) {
                            debugPrint("presented microblink screen")
                        }
                    }
                }
                
            })
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
