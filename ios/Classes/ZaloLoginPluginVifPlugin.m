#import "ZaloLoginPluginVifPlugin.h"
#if __has_include(<zalo_login_plugin_vif/zalo_login_plugin_vif-Swift.h>)
#import <zalo_login_plugin_vif/zalo_login_plugin_vif-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zalo_login_plugin_vif-Swift.h"
#endif

@implementation ZaloLoginPluginVifPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZaloLoginPluginVifPlugin registerWithRegistrar:registrar];
}
@end
