//
//  MTLZaloLoginPluginVifPlugin.swift
//  Runner
//
//  Created by SONDH on 12/28/20.
//

import Flutter
import ZaloSDK
import UIKit

public class MTLZaloLoginPluginVifPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zalo_login_plugin", binaryMessenger: registrar.messenger())
    let instance = MTLZaloLoginPluginVifPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        
        break;
    case "init":
        
        break;
    case "logIn":
        
        break;
    case "isAuthenticated":
        
        break;
    case "logOut":
        
        break;
    case "getInfo":
        
        break;
    default:
        break;
    }
    result(FlutterMethodNotImplemented)
  }
    
    private func getPlatformVersion(result : FlutterResult ) -> Void {
        
        result(1)
    }
}
