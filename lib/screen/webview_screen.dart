import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webview extends StatefulWidget {
  const Webview({Key? key, required this.url, this.onChangeUrl, this.appBar})
      : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();

  final String url;
  final Function(String url)? onChangeUrl;
  final PreferredSizeWidget? appBar;
}

class _WebviewState extends State<Webview> {
  late InAppWebViewController? _controller;
  late PullToRefreshController _pullToRefreshController;
  late String _title = '';
  final GlobalKey _key = GlobalKey();
  late bool isShowBack = true;
  late DateTime currentBackPressTime;

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          javaScriptCanOpenWindowsAutomatically: false,
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          cacheEnabled: true,
          clearCache: false,
          disableContextMenu: false,
          horizontalScrollBarEnabled: false,
          verticalScrollBarEnabled: false,
          supportZoom: false));

  void initState() {
    currentBackPressTime = DateTime.now();
    _title = widget.url;
    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _controller?.reload();
        } else if (Platform.isIOS) {
          _controller?.loadUrl(
            urlRequest: URLRequest(
              url: await _controller!.getUrl(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  void changeUrl(Uri? uri) {
    // setState(() {
    //   if (uri.toString().contains('/pos'))
    //     isShowBack = false;
    //   else
    //     isShowBack = true;
    //   _title = widget.onChangeUrl!(uri.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canGoBack = await _controller?.canGoBack() ?? false;
        if (canGoBack) {
          _controller?.goBack();
          return false;
        } else {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Nhấn back lần nữa để thoát ứng dụng'),
              duration: const Duration(seconds: 1),
              action: SnackBarAction(
                label: 'ACTION',
                onPressed: () {},
              ),
            ));
            return Future.value(false);
          }
          SystemNavigator.pop(); // add this.

          return Future.value(true);
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: InAppWebView(
          key: _key,
          pullToRefreshController: _pullToRefreshController,
          initialOptions: _options,
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          onWebViewCreated: ((controller) {
            _controller = controller;
          }),
          onTitleChanged: ((controller, title) {
            setState(
              () {
                if (title != null) _title = title.toString();
              },
            );
          }),
          onLoadStart: (controller, url) {
            changeUrl(url);
          },
          onLoadStop: ((controller, url) {
            changeUrl(url);
          }),
          onLoadError: (controller, url, code, message) {
            _pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            _pullToRefreshController.endRefreshing();
          },
          onUpdateVisitedHistory: (
            InAppWebViewController controller,
            Uri? url,
            bool? androidIsReload,
          ) {
            changeUrl(url);
          },
          onConsoleMessage: ((controller, consoleMessage) {
            // Logger.e(consoleMessage.message);
          }),
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      )),
    );
  }
}
