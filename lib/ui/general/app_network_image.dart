import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final String fallbackAssetImage;

  const AppNetworkImage({
    Key? key,
    required this.url,
    required this.fallbackAssetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage(fallbackAssetImage),
      image: NetworkImage(
        url,
        headers: {
          'accept': 'image/webp,image/*;q=0.85',
          'sec-fetch-dest': 'image',
        },
      ),
    );
  }
}
