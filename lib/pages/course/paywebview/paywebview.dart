import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yt_ulearning/common/widgets/base_text_widget.dart';
import 'package:yt_ulearning/common/widgets/flutter_toast.dart';
import 'package:yt_ulearning/pages/course/paywebview/bloc/payview_blocs.dart';
import 'package:yt_ulearning/pages/course/paywebview/bloc/payview_events.dart';
import 'package:yt_ulearning/pages/course/paywebview/bloc/payview_states.dart';

class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('----------my stripe url is ${args['url']}');

    context.read<PayWebViewBlocs>().add(TriggerWebView(args['url']));
  }

  @override
  void dispose() {
    webViewController.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayWebViewBlocs, PayWebViewStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar('Confirm Payment'),
          body: state.url == ""
              ? SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: const CircularProgressIndicator(),
                )
              : WebView(
                  initialUrl: state.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: {
                    JavascriptChannel(
                      name: "Pay",
                      onMessageReceived: (JavascriptMessage message) {
                        print(message.message);
                        Navigator.of(context).pop(message.message);
                      },
                    ),
                  },
                  onWebViewCreated: (WebViewController w) {
                    webViewController = w;
                  },
                ),
        );
      },
    );
  }
}
