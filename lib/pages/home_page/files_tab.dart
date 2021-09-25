import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';

class FilesTab extends StatefulWidget {
  const FilesTab({Key? key}) : super(key: key);

  @override
  _FilesTabState createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CarouselBannerAds(),
        ],
      ),
    );
  }
}
