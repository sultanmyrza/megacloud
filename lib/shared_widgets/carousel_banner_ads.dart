import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselBannerAds extends StatefulWidget {
  const CarouselBannerAds({
    Key? key,
  }) : super(key: key);

  @override
  _CarouselBannerAdsState createState() => _CarouselBannerAdsState();
}

class _CarouselBannerAdsState extends State<CarouselBannerAds> {
  int _current = 0;
  final _bannerAspectRatio = 3 / 1;
  final _imagePaths = [
    'assets/images/sample_banner_ads/sample_banner_ad_1.png',
    'assets/images/sample_banner_ads/sample_banner_ad_2.png',
    'assets/images/sample_banner_ads/sample_banner_ad_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    var carouselOptions = CarouselOptions(
      enableInfiniteScroll: false,
      autoPlay: false,
      viewportFraction: 1.0,
      enlargeCenterPage: true,
      aspectRatio: 3 / 1,
      onPageChanged: (index, reason) {
        setState(() => _current = index);
      },
    );

    var carouselItems = _imagePaths.map(_buildCarouselItem).toList();

    return AspectRatio(
      aspectRatio: _bannerAspectRatio,
      child: Stack(
        children: [
          CarouselSlider(items: carouselItems, options: carouselOptions),
          // Еще один вариант как ютюберы пишут UI код
          // чтобы наглядно было понятно что будет отображаться на экране
          _buildCarouselDotIndicator(),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Align _buildCarouselDotIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imagePaths.map((imagePath) {
            int index = _imagePaths.indexOf(imagePath);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromRGBO(111, 197, 58, 1)
                    : const Color.fromRGBO(255, 255, 255, 1),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
