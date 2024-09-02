import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/data/localData/local_database.dart';
import 'package:shareedu_app/view/screens/login/login_screen.dart';
import 'package:shareedu_app/view/screens/start/start_screen.dart';
import 'package:shareedu_app/view/widgets/app_bar.dart';
import 'package:shareedu_app/view/widgets/language_sheet.dart';
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
    return WillPopScope(
      onWillPop: () async {
        if (webViewController != null) {
          if (await webViewController!.canGoBack()) {
            await webViewController!.goBack();
          } else {
            if (widget.isGuestPage) {
              Navigator.of(context).pop();
            } else {
              showConfirmationDialog(
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
        }
        return false;
      },
      child: Scaffold(
        appBar: AppbarW(
          title: widget.title,
          hasBackButton: false,
          hasTrackingButton: !widget.isGuestPage,
          hasLang: !widget.isGuestPage,
        ),
        body: Directionality(
          textDirection: Language().changeDirection(),
          child: SafeArea(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                  "${widget.pageUrl}&UserLang=${LocalDatabase.getLanguageCode()}",
                ),
              ),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;
                // if ([
                //   'us05web.zoom.us',
                //   'chat.whatsapp.com',
                //   'www.youtube.com',
                //   'docs.google.com',
                //   'drive.google.com',
                //   't.me',
                //   'www.instagram.com',
                //   'twitter.com',
                //   'www.facebook.com',
                // ].contains(uri.host))
                if (uri.pathSegments.first == "DownloadFiles") {
                  openLink(navigationAction.request.url!);
                  return NavigationActionPolicy.CANCEL;
                } else if (uri.host == "ms.edu.sa") {
                  return NavigationActionPolicy.ALLOW;
                } else {
                  openLink(navigationAction.request.url!);
                  return NavigationActionPolicy.CANCEL;
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor, width: 2)),
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
