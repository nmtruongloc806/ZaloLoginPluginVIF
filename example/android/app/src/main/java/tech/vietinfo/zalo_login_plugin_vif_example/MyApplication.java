package tech.vietinfo.zalo_login_plugin_vif_example;

import android.app.Activity;
import android.app.Application;

import androidx.annotation.CallSuper;

import com.zing.zalo.zalosdk.oauth.ZaloSDKApplication;

import io.flutter.view.FlutterMain;

public class MyApplication extends Application {
    @Override
    @CallSuper
    public void onCreate() {
        super.onCreate();
        ZaloSDKApplication.wrap(this);
        FlutterMain.startInitialization(this);
    }

    private Activity mCurrentActivity = null;

    public Activity getCurrentActivity() {
        return mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }
}