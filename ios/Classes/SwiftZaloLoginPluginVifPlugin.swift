//
//  MTLZaloLoginPluginVifPlugin.swift
//  Runner
//
//  Created by SONDH on 12/28/20.
//

import Flutter
import ZaloSDK
import UIKit

public class SwiftZaloLoginPluginVifPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zalo_login_plugin", binaryMessenger: registrar.messenger())
    print("da dang ky zalo_login_plugin")
    let instance = SwiftZaloLoginPluginVifPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "init":
        self.`init`(result: result)
        break;
    case "logIn":
        self.login(result: result)
        break;
    case "isAuthenticated":
        self.isAuthenticated(result: result)
        break;
    case "logOut":
        self.logOut(result: result)
        break;
    case "getInfo":
        self.getInfo(result: result)
        break;
    default:
        break;
    }
    result(FlutterMethodNotImplemented)
  }
    
    private func `init`(result : FlutterResult) -> Void {
        let zaloAppID : NSString = Bundle.main.object(forInfoDictionaryKey: "ZaloAppID") as! NSString;
        ZaloSDK.sharedInstance()?.initialize(withAppId: zaloAppID as String)
        result(zaloAppID)
    }
    
    private func login(result : @escaping FlutterResult) -> Void {
        do{
            print("da vao login")
            ZaloSDK.sharedInstance()?.unauthenticate();
            let appDelegate = UIApplication.shared.delegate as! FlutterAppDelegate;
            let rootViewController = appDelegate.window.rootViewController;
            ZaloSDK.sharedInstance()?.authenticateZalo(with: ZAZAloSDKAuthenTypeViaZaloAppAndWebView, parentController: rootViewController, isShowLoading: true, handler: { (response : ZOOauthResponseObject?) in
                if(response?.isSucess == true){
                    print("da vao login sucess")
                    //let errorCode = String(format: "%ld", response!.errorCode)
                    result([
                        "userID" :response!.userId ?? "",
                        "oauthCode" :response!.oauthCode ?? "",
                        "errorCode" :response!.errorCode ,
                        "errorMessage" :response!.errorMessage ?? "",
                        "displayName" :response!.displayName ?? "",
                        "dob" :response!.dob ?? "",
                        "gender" :response!.gender ?? ""
                    ])
                }
                else{
                    print("da vao login fail")
                    result([
                        "errorCode" : -1 ,
                        "errorMessage" : response?.errorMessage ?? "dang nhap that bai",
                    ])
                }
            })
        } catch let ex {
            print("da vao login exception")
            result([
                "errorCode" : -1 ,
                "errorMessage" : ex.localizedDescription,
            ])
        }
    }
    
    private func isAuthenticated(result : @escaping FlutterResult) -> Void {
        ZaloSDK.sharedInstance()?.isAuthenticatedZalo(completionHandler: { (response : ZOOauthResponseObject?) in
            if(UInt32(response?.errorCode ?? -1) == kZaloSDKErrorCodeNoneError.rawValue) {
                result(1)
            }
            else{
                result(0)
            }
        })
    }
    
    private func logOut(result : FlutterResult) -> Void {
        ZaloSDK.sharedInstance()?.unauthenticate()
        result(1)
    }
    
    private func getInfo(result : @escaping FlutterResult) -> Void {
        ZaloSDK.sharedInstance()?.getZaloUserProfile(callback: { (response : ZOGraphResponseObject?) in
            do{
                result(response?.data)
            } catch let ex {
                result(FlutterError(code: "-1", message: ex.localizedDescription, details: nil))
            }
        })
    }
}
