plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.medicinal_plants"
    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.medicinal_plants"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            extensions.findByName("android")?.let { androidExt ->
                (androidExt as ExtensionAware).extensions.configure<com.android.build.gradle.BaseExtension> {
                    if (namespace == null) {
                        namespace = project.group.toString() // Set namespace as fallback
                    }
                }

                tasks.configureEach {
                    if (name.contains("processDebugManifest") || name.contains("processReleaseManifest")) {
                        doFirst {
                            val manifestFile = file("${project.projectDir}/src/main/AndroidManifest.xml")
                            if (manifestFile.exists()) {
                                var manifestContent = manifestFile.readText()
                                if (manifestContent.contains("package=")) {
                                    manifestContent = manifestContent.replace(Regex("""package="[^"]*""""), "")
                                    manifestFile.writeText(manifestContent)
                                    println("Removed 'package' attribute from $manifestFile")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}