//
//  MTLZaloLoginPluginVifPlugin.swift
//  Runner
//
//  Created by SONDH on 12/28/20.
//

import Flutter
import ZaloSDK
import UIKit

public class MTLZaloLoginPluginVifPlugin: NSObject {
    var cntroller : FlutterViewController?
  public func register(with registrar: FlutterViewController) {
    let channel = FlutterMethodChannel(name: "zalo_login_plugin_mtl", binaryMessenger: registrar.binaryMessenger)
    cntroller = registrar
    channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        self.handle(call , result: result)
    })
    print("da dang ky zalo_login_plugin_mtl")
    
//    let instance = MTLZaloLoginPluginVifPlugin()
//    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "init":
        self.`init`(result: result)
        break;
    case "logIn":
        login(result: result)
        break;
    case "isAuthenticated":
        isAuthenticated(result: result)
        break;
    case "logOut":
        logOut(result: result)
        break;
    case "getInfo":
        getInfo(result: result)
        break;
    default:
        break;
    }
    result(FlutterMethodNotImplemented)
  }
    
    private func `init`(result : FlutterResult) -> Void {
//        let zaloAppID : NSString = Bundle.main.object(forInfoDictionaryKey: "2793670590480591223") as! NSString;
        let zaloAppID : String = "2793670590480591223";
        ZaloSDK.sharedInstance()?.initialize(withAppId: zaloAppID)
        result(zaloAppID)
    }
    
    private func login(result : @escaping FlutterResult) -> Void {
        do{
            print("MTL da vao login")
            ZaloSDK.sharedInstance()?.unauthenticate();
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let rootViewController = appDelegate.window.rootViewController;
   
            ZaloSDK.sharedInstance()?.authenticateZalo(with: ZAZaloSDKAuthenTypeViaWebViewOnly, parentController: rootViewController, isShowLoading: true, handler: { (response : ZOOauthResponseObject?) in
                print("MTL da vao login 2")
                if(response?.isSucess == true) {
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
            })
        } catch let ex {
            print("MTL da vao loi")
            result([
                "errorCode" : -1 ,
                "errorMessage" : ex.localizedDescription,
            ])
        }
    }
    
    private func isAuthenticated(result : @escaping FlutterResult) -> Void {
        ZaloSDK.sharedInstance()?.isAuthenticatedZalo(completionHandler: { (response : ZOOauthResponseObject?) in
            if response?.isSucess == true {
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
