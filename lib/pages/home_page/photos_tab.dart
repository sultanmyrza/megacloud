import 'package:flutter/material.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';

class PhotosTab extends StatefulWidget {
  const PhotosTab({Key? key}) : super(key: key);

  @override
  _PhotosTabState createState() => _PhotosTabState();
}

class _PhotosTabState extends State<PhotosTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          CarouselBannerAds(),
          Text("TODO: implement PhotosTab")
        ],
      ),
    );
  }
}
