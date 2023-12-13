import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaylin_studio/bloc/bloc_observer.dart';
import 'package:permission_handler/permission_handler.dart';

enum Flavor { DEV, STAGING, PRODUCT }

class AppConfigs {
  final Flavor flavor;
  final FlavorValues values;

  static AppConfigs? _instance;

  AppConfigs._internal(
    this.flavor,
    this.values,
  );

  factory AppConfigs(Flavor flavor) {
    return _instance ??= AppConfigs._internal(
      flavor,
      flavor.get(),
    );
  }

  static AppConfigs get instance {
    return _instance!;
  }

  Future<void> setup() async {
    WidgetsFlutterBinding.ensureInitialized();

    var camera = await Permission.camera.status;
    var photo = await Permission.photos.status;
    var mediaLibrary = await Permission.mediaLibrary.status;
    var microphone = await Permission.microphone.status;

    if (camera == PermissionStatus.denied) {
      camera = await Permission.camera.request();
    }
    if (photo == PermissionStatus.denied) {
      photo = await Permission.photos.request();
    }
    if (mediaLibrary == PermissionStatus.denied) {
      mediaLibrary = await Permission.mediaLibrary.request();
    }
    if (microphone == PermissionStatus.denied) {
      microphone = await Permission.microphone.request();
    }
    Bloc.observer = SimpleBlocObserver();
  }
}

extension FlavorExtension on Flavor {
  FlavorValues get() {
    switch (this) {
      case Flavor.DEV:
        return FlavorValues(
            appName: 'KaylinStudio Dev',
            odooHost: 'https://kaylinstudio.com/web',
            isDebugEnabled: true);
      case Flavor.STAGING:
        return FlavorValues(
            appName: 'KaylinStudio Staging',
            odooHost: 'https://kaylinstudio.com/web',
            isDebugEnabled: true);
      case Flavor.PRODUCT:
        return FlavorValues(
            appName: 'KaylinStudio',
            odooHost: 'https://kaylinstudio.com/web',
            isDebugEnabled: false);

      default:
        return FlavorValues(
            appName: 'KaylinStudio',
            odooHost: 'https://kaylinstudio.com/web',
            isDebugEnabled: false);
    }
  }
}

class FlavorValues {
  final String appName;
  final String odooHost;
  final bool? isDebugEnabled;

  FlavorValues(
      {required this.appName,
      required this.odooHost,
      required this.isDebugEnabled});
}
