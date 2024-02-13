import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

  Future<void> launchInBrowser(Uri url) async {
    // Future<void>? _launched;
    final result = await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    );
    if (!result) {
      throw Exception('Could not launch $url');
    }
  }


