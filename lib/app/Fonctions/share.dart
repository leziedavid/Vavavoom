import 'package:flutter_share/flutter_share.dart';

Future<void> share(String title, String? text, String linkUrl) async {
  final result = await FlutterShare.share(
      title: title,
      text: text,
      linkUrl: linkUrl,
      chooserTitle: 'Example Chooser Title');
  if (result == null) {
    throw Exception('Could not launch $linkUrl');
  }
}
