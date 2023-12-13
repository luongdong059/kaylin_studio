import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kaylin_studio/bloc/app/app_cubit.dart';
import 'package:kaylin_studio/screen/barcode_test_screen.dart';
import 'package:kaylin_studio/screen/webview_screen.dart';
import 'package:kaylin_studio/themes/app_colors.dart';
import 'package:kaylin_studio/utils/snackbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   elevation: 2,
          //   title: const Text(
          //     'Kaylin Studio Mini App',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _textEditingController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Url',
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                    ),
                    controller: _textEditingController,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => AppColors.branchStrongBlue),
                        ),
                        onPressed: () {
                          setState(() {
                            _textEditingController.text =
                                'https://KaylinStudio-staging.smartinnotech.io';
                          });
                          ToastCustom.showToast(
                              isBottom: true,
                              context: context,
                              content: 'Staging environment was choose',
                              status: Toasts.SUCCESS);
                        },
                        child: Text(
                          'Use Staging',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => AppColors.branchStrongBlue),
                        ),
                        onPressed: () {
                          setState(() {
                            _textEditingController.text =
                                'https://KaylinStudio-dev.smartinnotech.io';
                          });
                          ToastCustom.showToast(
                              isBottom: true,
                              context: context,
                              content: 'Dev environment was choose',
                              status: Toasts.SUCCESS);
                        },
                        child: Text(
                          'Use Dev',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => AppColors.branchStrongBlue),
                        ),
                        onPressed: () {
                          setState(() {
                            _textEditingController.text =
                                'https://KaylinStudio-test.smartinnotech.io';
                          });
                          ToastCustom.showToast(
                              isBottom: true,
                              context: context,
                              content: 'Test environment was choose',
                              status: Toasts.SUCCESS);
                        },
                        child: Text(
                          'Use Test',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_textEditingController.text.length > 0) {
                      bool isValidURL =
                          Uri.parse(_textEditingController.text).isAbsolute;
                      if (isValidURL) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Webview(url: _textEditingController.text)),
                        );
                      } else {
                        ToastCustom.showToast(
                            isBottom: true,
                            context: context,
                            content: 'Url invalid',
                            status: Toasts.ERROR);
                      }
                    } else {
                      ToastCustom.showToast(
                          isBottom: true,
                          context: context,
                          content: 'Please enter Url',
                          status: Toasts.ERROR);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(
                        'SALE',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SmallItem(
                          color: Colors.indigo,
                          title: 'Device test',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BarcodeScanner()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SmallItem(
                          color: Colors.green,
                          title: 'Reset',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SmallItem(
                          color: Colors.teal,
                          title: 'About',
                          onTap: () async {
                            final deviceInfoPlugin = DeviceInfoPlugin();
                            final deviceInfo =
                                await deviceInfoPlugin.deviceInfo;
                            final allInfo = deviceInfo.data;

                            ToastCustom.showToast(
                                isBottom: true,
                                context: context,
                                content: '$allInfo',
                                status: Toasts.INFO);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SmallItem(
                          color: Colors.red,
                          title: 'Quit',
                          onTap: () {
                            exit(0);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Dark mode',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      CupertinoSwitch(
                        value: state.isDarkMode,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          BlocProvider.of<AppCubit>(context)
                              .changeTheme(!state.isDarkMode);
                        },
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: _getInfo(),
                    builder: (context, snapshot) => Center(
                          child: Text(
                            'Build number ${snapshot.data != null ? snapshot.data!.version : ''} ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     BlocProvider.of<AppCubit>(context).changeTheme(!state.isDarkMode);
          //     await AppConfigs(Flavor.DEV).setup();
          //   },
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ),
        );
      },
    );
  }
}

class SmallItem extends StatelessWidget {
  const SmallItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

Future<PackageInfo> _getInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  // String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;
  return packageInfo;
}
