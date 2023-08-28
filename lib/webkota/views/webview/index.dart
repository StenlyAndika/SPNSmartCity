import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:smartcity/webkota/models/service/model_service.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({Key? key}) : super(key: key);

  static const nameRoute = '/serviceview';

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  late Data service;
  late WebViewController webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service = ModalRoute.of(context)!.settings.arguments as Data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
              return false;
            } else {
              return true;
            }
          },
          child: Column(
            children: [
              progress < 1
                  ? SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        value: progress,
                        color: Colors.red,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: WebView(
                  initialUrl: service.link,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100;
                  }),
                  gestureNavigationEnabled: true,
                  geolocationEnabled: false, //support geolocation or not
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
