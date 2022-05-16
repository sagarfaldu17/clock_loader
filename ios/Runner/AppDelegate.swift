import UIKit
import Flutter
import LocalAuthentication

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var flutterbBioMatricChannel : FlutterMethodChannel!
    var flutterController : FlutterViewController!
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.flutterController  = window?.rootViewController as? FlutterViewController
        GeneratedPluginRegistrant.register(with: self)
        
        self.flutterbBioMatricChannel = FlutterMethodChannel(name: "bioMatricMethodChannel", binaryMessenger: flutterController as! FlutterBinaryMessenger)
        
        self.flutterbBioMatricChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            DispatchQueue.main.async {
                
                let laContext = LAContext()
                var error: NSError?
                // let biometricsPolicy = LAPolicy.deviceOwnerAuthentication
                let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
                print("Entered in finding room ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ")
                if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
                    
                    if let laError = error {
                        print("laError - \(laError)")
                        return
                    }
                    
                    UINavigationBar.appearance().tintColor = UIColor.red
                    
                    var localizedReason = "My Reason to be displayed on face id prompt"
                    if #available(iOS 11.0, *) {
                        if (laContext.biometryType == LABiometryType.faceID) {
                            //localizedReason = "Unlock using Face ID"
                            print("FaceId support ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ")
                        } else if (laContext.biometryType == LABiometryType.touchID) {
                            //localizedReason = "Unlock using Touch ID"
                            print("TouchId support ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ")
                        } else {
                            //localizedReason = "Unlock using Application Passcode"
                            print("No Biometric support ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ")
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                switch(call.method){
                case "getDeviceBioMatricType":
                    //                    self.window?.rootViewController?.showAlert(msg: "getVoiPToken \(voipToken) >>>> >>>> >>>> >>>> >>>> >>>> ")
                    let supportedBiometryType: String = self.supportedBiometryType()
                    let deviceBioMatricType: String = supportedBiometryType
                    result(deviceBioMatricType)
                    break;
                    
                case "isBioMatricAvailable":
                    let supportedBiometryType: String = self.supportedBiometryType()
                    let isBioMatricAvailable: Bool = (supportedBiometryType == "touchID" || supportedBiometryType == "faceID")
                    result(isBioMatricAvailable)
                    break;
                default:
                    break;
                }
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func supportedBiometryType() -> String {
        let laContext = LAContext()
        if #available(iOS 11.2, *) {
            if (laContext.biometryType == LABiometryType.touchID) {
                return "touchID"
                print("LABiometryType.touchID \(LABiometryType.touchID) >>>> >>>> >>>> >>>> >>>> >>>> >>>> ")
            } else if (laContext.biometryType == LABiometryType.faceID) {
                return "faceID"
                print("LABiometryType.faceID \(LABiometryType.faceID) >>>> >>>> >>>> >>>> >>>> >>>> >>>> ")
            } else {
                return "none"
                print("LABiometryType.none \(LABiometryType.none) >>>> >>>> >>>> >>>> >>>> >>>> >>>> ")
            }
        }
        return "device is below 11.2"
    }
}
