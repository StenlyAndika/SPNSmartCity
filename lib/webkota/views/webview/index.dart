import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:smartcity/webkota/models/service/model_service.dart';

import '../../../home.dart';

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
      backgroundColor: const Color.fromARGB(255, 3, 65, 180),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Color(0xFFEDECF2)),
              child: SafeArea(
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
                          geolocationEnabled:
                              false, //support geolocation or not
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, Home.nameRoute),
                  icon: const Icon(
                    Icons.home,
                    size: 35,
                  ),
                  color: Colors.white,
                ),
                const Text(
                  'Menu Utama',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
