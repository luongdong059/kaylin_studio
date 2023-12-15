import 'package:flutter/material.dart';
import 'package:kaylin_studio/config/configs.dart';

import 'main.dart';

void main() async {
  await AppConfigs(Flavor.PRODUCT).setup();

  runApp(KaylinCenter1());
}
