import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zalo_login_plugin_vif/zalo_login_plugin_vif.dart';

void main() {
  const MethodChannel channel = MethodChannel('zalo_login_plugin_vif');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ZaloLoginPluginVif.platformVersion, '42');
  });
}
