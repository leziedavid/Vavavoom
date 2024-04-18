import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrImageViews extends StatelessWidget {
  final String url;

  const QrImageViews({
    Key? key,
    required this.url,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Material(
      borderRadius: BorderRadius.circular(7),
      elevation: 2,
      child: QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 110,
            gapless: false,
            // embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80), ),
          ),
    );
  }
}
