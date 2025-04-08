## Crash Details

**Crash Thread**: `Thread[main,5,main]`  
**Crash Timestamp**: `2025-04-06 18:54:55.281 UTC`  

**Crash Message**:
```
View=DecorView@930cdf3[] not attached to window manager
```


### Stacktrace

```
java.lang.IllegalArgumentException: View=DecorView@930cdf3[] not attached to window manager
	at android.view.WindowManagerGlobal.findViewLocked(WindowManagerGlobal.java:485)
	at android.view.WindowManagerGlobal.removeView(WindowManagerGlobal.java:394)
	at android.view.WindowManagerImpl.removeViewImmediate(WindowManagerImpl.java:126)
	at android.app.Dialog.dismissDialog(Dialog.java:371)
	at android.app.Dialog.dismiss(Dialog.java:354)
	at com.termux.app.TermuxActivity$1$1$2$3.run(TermuxActivity.java:385)
	at android.app.Activity.runOnUiThread(Activity.java:6199)
	at com.termux.app.TermuxActivity$1$1$2.run(TermuxActivity.java:382)
	at android.os.Handler.handleCallback(Handler.java:790)
	at android.os.Handler.dispatchMessage(Handler.java:99)
	at android.os.Looper.loop(Looper.java:164)
	at android.app.ActivityThread.main(ActivityThread.java:6746)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:438)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:807)

```
##


## NSC App Info

**APP_NAME**: `NSC`  
**PACKAGE_NAME**: `com.termux`  
**VERSION_NAME**: `1.0.1`  
**VERSION_CODE**: `20240420`  
**UID**: `10262`  
**TARGET_SDK**: `28`  
**IS_DEBUGGABLE_BUILD**: `false`  
**SE_PROCESS_CONTEXT**: `u:r:untrusted_app:s0:c512,c768`  
**SE_FILE_CONTEXT**: `u:object_r:app_data_file:s0:c512,c768`  
**SE_INFO**: `default:targetSdkVersion=28:complete`  
**TERMUX_APP_PACKAGE_MANAGER**: `APT`  
**TERMUX_APP_PACKAGE_VARIANT**: `APT_ANDROID_7`  
**APK_RELEASE**: `Github`  
**SIGNING_CERTIFICATE_SHA256_DIGEST**: `B6DA01480EEFD5FBF2CD3771B8D1021EC791304BDD6C4BF41D3FAABAD48EE5E1`  
##


## Device Info

### Software

**OS_VERSION**: `4.4.78-perf+`  
**SDK_INT**: `27`  
**RELEASE**: `8.1.0`  
**ID**: `Mr.TeHMaz`  
**DISPLAY**: `Moded By Mr.TeHMaz`  
**INCREMENTAL**: `Moded.By`  
**SECURITY_PATCH**: `2018-10-01`  
**IS_DEBUGGABLE**: `0`  
**IS_TREBLE_ENABLED**: `true`  
**TYPE**: `user`  
**TAGS**: `release-keys`  

### Hardware

**MANUFACTURER**: `samsung`  
**BRAND**: `samsung`  
**MODEL**: `SM-G6200`  
**PRODUCT**: `Phoenix`  
**BOARD**: `sdm660`  
**HARDWARE**: `qcom`  
**DEVICE**: `Phoenix`  
**SUPPORTED_ABIS**: `arm64-v8a, armeabi-v7a, armeabi`  
##
