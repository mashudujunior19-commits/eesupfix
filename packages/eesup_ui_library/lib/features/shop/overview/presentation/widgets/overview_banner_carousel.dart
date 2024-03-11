import 'package:cached_network_image/cached_network_image.dart';
import 'package:eesup_data_source/shopping/models/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shimmer/shimmer.dart';

class OverviewBannerCarousel extends StatelessWidget {
  const OverviewBannerCarousel({
    super.key,
    required this.interval,
    required this.banners,
  });
  final Duration interval;
  final AdBanner banners;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 200,
        showIndicator: false,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: interval,
        autoPlayAnimationDuration: 1.seconds,
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
        slideIndicator: SequentialFillIndicator(),
      ),
      items: banners.content.map((banner) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: banner.url,
              fit: BoxFit.fill,
              placeholder: (context, url) => const LoadingShimmer(),
              errorWidget: (context, url, error) => const LoadingShimmer(),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300.withOpacity(.5),
      highlightColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            width: MediaQuery.sizeOf(context).width,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 50,
              top: 5,
              left: 15,
              bottom: 15,
            ),
            width: MediaQuery.sizeOf(context).width,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 70,
              top: 5,
              left: 15,
              bottom: 15,
            ),
            width: MediaQuery.sizeOf(context).width,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(13),
            ),
          )
        ],
      ),
    );
  }
}
