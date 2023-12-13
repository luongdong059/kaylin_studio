import 'package:flutter/material.dart';
import 'package:kaylin_studio/utils/snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with SingleTickerProviderStateMixin {
  late String _saleDate;

  BarcodeCapture? barcode;
  bool isStarted = true;
  bool isUpload = false;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    autoStart: true,
    // formats: [BarcodeFormat.qrCode],
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.noDuplicates,
    detectionTimeoutMs: 1000,
    // returnImage: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Device test',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Stack(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 16.0, bottom: 0),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                // blurRadius: 1,
                                // spreadRadius: 0.1,
                              )
                            ]),
                        height: MediaQuery.of(context).size.height * 70 / 100,
                        child: Stack(
                          children: [
                            MobileScanner(
                              controller: controller,
                              errorBuilder: (context, error, child) {
                                return Container();
                              },
                              fit: BoxFit.cover,
                              onDetect: (barcode) {
                                ToastCustom.showToast(
                                    isBottom: true,
                                    context: context,
                                    content:
                                        barcode.barcodes.first.rawValue ?? '',
                                    status: Toasts.INFO);
                              },
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: SvgPicture.asset(
                            //     AppAssets.scanqr_ic,
                            //     width: AppDimens.getWidth(context),
                            //   ),
                            // ),
                            // if (state is QrActivatingState ||
                            //     state is UploadingState)
                            //   Align(
                            //     alignment: Alignment.center,
                            //     child: CupertinoActivityIndicator(
                            //       radius: 15,
                            //       color: AppColors.branch,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: controller.hasTorchState,
                            builder: (context, state, child) {
                              if (state != true) {
                                return const SizedBox.shrink();
                              }
                              return IconButton(
                                color: Colors.white,
                                icon: ValueListenableBuilder(
                                  valueListenable: controller.torchState,
                                  builder: (context, state, child) {
                                    if (state == null) {
                                      return const Icon(
                                        Icons.flash_off,
                                        color: Colors.grey,
                                      );
                                    }
                                    return Column(
                                      children: [
                                        Icon(
                                          state == TorchState.off
                                              ? Icons.flash_off
                                              : Icons.flash_on,
                                          color: state == TorchState.off
                                              ? Colors.grey
                                              : Colors.green,
                                        ),
                                      ],
                                    );
                                    // switch (state as TorchState) {
                                    //   case TorchState.off:
                                    //     return const Icon(
                                    //       Icons.flash_off,
                                    //       color: AppColors.border,
                                    //       size: 24,
                                    //     );
                                    //   case TorchState.on:
                                    //     return const Icon(
                                    //       Icons.flash_on,
                                    //       color: AppColors.branch,
                                    //       size: 24,
                                    //     );
                                    // }
                                  },
                                ),
                                iconSize: 24.0,
                                onPressed: () => controller.toggleTorch(),
                              );
                            },
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: isStarted
                                ? const Icon(Icons.stop)
                                : const Icon(Icons.play_arrow),
                            iconSize: 32.0,
                            onPressed: _startOrStop,
                          ),
                          IconButton(
                            color: Colors.green,
                            icon: ValueListenableBuilder(
                              valueListenable: controller.cameraFacingState,
                              builder: (context, state, child) {
                                if (state == null) {
                                  return const Icon(Icons.camera_front);
                                }
                                switch (state as CameraFacing) {
                                  case CameraFacing.front:
                                    return const Icon(Icons.camera_front);
                                  case CameraFacing.back:
                                    return const Icon(Icons.camera_rear);
                                }
                              },
                            ),
                            iconSize: 24.0,
                            onPressed: () => controller.switchCamera(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}


// Check