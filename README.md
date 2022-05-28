# Togg - Flutter Developer Assessment


## Info

An app made with Flutter for glazing at places that provided by gRPC endpoint.


## :star: Techs

* Firebase Crashlytics
* Firebase Analytics
* gRPC endpoint
* MVVM architecture
* Unit Test
* GMaps

  <br>

## 🚀&nbsp; Installation

1. Install Packages in pubspec.yaml
```
flutter pub get
```

  <br>
2. Configure Project (SKIP THIS SECTION FOR NOW !!!!!!!!)

* Android
```
    android/build.gradle
    
    dependencies {
        ...
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.0'
        ...
    }
```

```
    android/app/build.gradle
    
...
apply plugin: 'com.google.firebase.crashlytics'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
...
    defaultConfig {
        ...
        minSdkVersion 21
        ...
    }
    
    dependencies {
    ...
    // Import the BoM for the Firebase platform
    implementation platform('com.google.firebase:firebase-bom:30.1.0')

    //IF YOU ARE USING KOTLIN BASED FLUTTER
    implementation 'com.google.firebase:firebase-crashlytics-ktx'
    implementation 'com.google.firebase:firebase-analytics-ktx'
    
    //IF YOU'RE USING JAVA BASED FLUTTER
    implementation 'com.google.firebase:firebase-crashlytics'
    implementation 'com.google.firebase:firebase-analytics'
    ...
}
```

* iOS
```
INSIDE THE ios/Podfile MAKE 10 OR HIGHER, FIREBASE DEPENDS ON 9 OR 10 ACCORDING TO WHICH PACKAGES ARE USING
  platform :ios, '10.0'
```
  <br>
3. Set Google Map API KEY (SKIP THIS SECTION FOR NOW!!!!!!)

* Android
```
You can get it from cloud.google.com -> Enabling Map SDK for Android and creating credential

INSIDE THE android/app/src/main/AndroidManifest.xml ADD BELOW;

<application>
...
    <meta-data android:name="com.google.android.geo.API_KEY"
           android:value="ENTER_YOUR_API_KEY"/>
...
</application>
```

* iOS
```
You can get it from cloud.google.com -> Enabling Map SDK for iOS and creating credential

INSIDE THE ios/Runner/AppDelegate.swift SHOULD LOOKS LIKE THIS;

import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("ENTER_YOUR_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```
  <br>
4. Run
