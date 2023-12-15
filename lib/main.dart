import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaylin_studio/bloc/app/app_cubit.dart';
import 'package:kaylin_studio/config/configs.dart';
import 'package:kaylin_studio/screen/dashboard_screen.dart';
import 'package:kaylin_studio/screen/webview_screen.dart';
import 'package:kaylin_studio/themes/app_themes.dart';

class KaylinCenter extends StatelessWidget {
  const KaylinCenter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        )
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner:
                AppConfigs.instance.values.isDebugEnabled ?? true,
            title: 'Kaylin Studio',
            theme: state.isDarkMode ? AppThemes.dark : AppThemes.light,
            home: const Dashboard(),
          );
        },
      ),
    );
  }
}

class KaylinCenter1 extends StatelessWidget {
  const KaylinCenter1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        )
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner:
                AppConfigs.instance.values.isDebugEnabled ?? true,
            title: 'Kaylin Studio',
            theme: state.isDarkMode ? AppThemes.light : AppThemes.dark,
            home: LaunchBrower(),
          );
        },
      ),
    );
  }
}

class LaunchBrower extends StatefulWidget {
  const LaunchBrower({
    Key? key,
  }) : super(key: key);

  @override
  State<LaunchBrower> createState() => _LaunchBrowerState();
}

class _LaunchBrowerState extends State<LaunchBrower> {
  late DateTime currentBackPressTime;

  void initState() {
    super.initState();
    currentBackPressTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Webview(url: AppConfigs.instance.values.odooHost),
    );
  }
}
