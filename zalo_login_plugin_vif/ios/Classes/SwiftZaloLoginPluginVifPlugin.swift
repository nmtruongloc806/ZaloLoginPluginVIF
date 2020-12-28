import Flutter
import UIKit

public class SwiftZaloLoginPluginVifPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zalo_login_plugin_vif", binaryMessenger: registrar.messenger())
    let instance = SwiftZaloLoginPluginVifPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
