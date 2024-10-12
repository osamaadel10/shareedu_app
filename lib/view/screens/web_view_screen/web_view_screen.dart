import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/data/local_database.dart';
import 'package:shareedu_app/view/screens/login/login_screen.dart';
import 'package:shareedu_app/view/screens/start/start_screen.dart';
import 'package:shareedu_app/view/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/styles/colors.dart';
import '../../../controllers/authServices/auth_services.dart';
import '../../widgets/dialogs.dart';

class WebViewScreen extends StatefulWidget {
  final String pageUrl;
  final String title;
  final bool isGuestPage;
  const WebViewScreen({
    super.key,
    required this.pageUrl,
    required this.title,
    this.isGuestPage = false,
  });
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late PullToRefreshController pullToRefreshController;
  InAppWebViewController? webViewController;
  bool loading = true;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      cacheEnabled: true,
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: await webViewController?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarW(
          title: widget.title,
          hasBackButton: false,
          hasTrackingButton: LocalDatabase.getUserIndex() == 4,
          hasLang: !widget.isGuestPage,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                  "${widget.pageUrl}&UserLang=${LocalDatabase.getLanguageCode()}",
                ),
              ),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  loading = true;
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  loading = false;
                });
                pullToRefreshController.endRefreshing();
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                Uri? currentUrl = await webViewController?.getUrl();
                var uri = navigationAction.request.url!;
                if (uri.pathSegments.last.contains('.docx') ||
                    uri.pathSegments.last.contains('.pdf') ||
                    uri.pathSegments.last.contains('.csv') ||
                    uri.pathSegments.last.contains('.xlsx') ||
                    uri.pathSegments.last.contains('.pptx') ||
                    uri.pathSegments.last.contains('.txt') ||
                    uri.pathSegments.last.contains('.jpg') ||
                    uri.pathSegments.last.contains('.png') ||
                    uri.pathSegments.last.contains('.zip') ||
                    uri.pathSegments.last.contains('.rar') ||
                    uri.host != "demo.shareedu-lms.com") {
                  await openLink(uri);
                  webViewController!.loadUrl(
                    urlRequest: URLRequest(url: currentUrl),
                  );
                  return NavigationActionPolicy.CANCEL;
                } else if (uri.pathSegments.first == "DownloadFiles") {
                  await openLink(uri);
                  webViewController!.loadUrl(
                    urlRequest: URLRequest(url: currentUrl),
                  );
                  return NavigationActionPolicy.CANCEL;
                } else if (uri.host == "demo.shareedu-lms.com") {
                  return NavigationActionPolicy.ALLOW;
                } else {
                  await openLink(uri);
                  webViewController!.loadUrl(
                    urlRequest: URLRequest(url: currentUrl),
                  );
                }
                return NavigationActionPolicy.CANCEL;
              },
            ),
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => _doAction(2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.isGuestPage
                        ? Icon(
                            Icons.login_rounded,
                            color: const Color.fromARGB(255, 120, 120, 120),
                            size: 35.sp,
                          )
                        : Icon(
                            Icons.logout_rounded,
                            color: const Color.fromARGB(255, 120, 120, 120),
                            size: 35.sp,
                          ),
                    const SizedBox(height: 3),
                    Text(
                      widget.isGuestPage ? 'login'.tr : 'logout'.tr,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _doAction(1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: primaryColor,
                      size: 40.sp,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'main'.tr,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _doAction(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.replay,
                      color: const Color.fromARGB(255, 120, 120, 120),
                      size: 35.sp,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'back'.tr,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doAction(int index) async {
    switch (index) {
      case 2:
        if (widget.isGuestPage) {
          Get.offAll(() => const StartScreen());
          Get.to(() => const LoginScreen());
        } else {
          showConfirmationDialog(
            context,
            title: 'logout'.tr,
            subtitle1: 'logoutHint'.tr,
            onYesPressed: () => AuthServices.logout(context),
          );
        }
        break;
      case 1:
        if (widget.isGuestPage) {
          Navigator.of(context).pop();
        } else {
          webViewController!.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(widget.pageUrl)),
          );
        }
        break;
      case 0:
        if (await webViewController!.canGoBack()) {
          webViewController!.goBack();
        } else {
          if (widget.isGuestPage) {
            Get.back();
          } else {
            showConfirmationDialog(
              // ignore: use_build_context_synchronously
              context,
              title: 'exitHint'.tr,
              subtitle1: "",
              onYesPressed: () {
                Navigator.of(context).pop();
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
            );
          }
        }
        break;
    }
  }

  Future<void> openLink(Uri link) async {
    if (!await launchUrl(
      link,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      await launchUrl(link);
    }
  }
}
