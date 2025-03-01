// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:data/shopping/models/ad_banner.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
// import 'package:shimmer/shimmer.dart';

// class OverviewBannerCarousel extends StatelessWidget {
//   const OverviewBannerCarousel({
//     super.key,
//     required this.interval,
//     required this.banners,
//     required this.onBannerTap,
//   });
//   final Duration interval;
//   final AdBanner banners;
//   final Function(String url) onBannerTap;

//   @override
//   Widget build(BuildContext context) {
//     return FlutterCarousel(
//       options: CarouselOptions(
//         height: 200,
//         showIndicator: false,
//         autoPlay: true,
//         enableInfiniteScroll: true,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         autoPlayInterval: interval,
//         autoPlayAnimationDuration: 1.seconds,
//         pauseAutoPlayOnTouch: true,
//         pauseAutoPlayOnManualNavigate: true,
//         slideIndicator: SequentialFillIndicator(),
//       ),
//       items: banners.content.map((banner) {
//         return GestureDetector(
//           onTap: () {
//             onBannerTap(banner.url);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(5),
//               child: CachedNetworkImage(
//                 imageUrl: banner.url,
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) => const LoadingShimmer(),
//                 errorWidget: (context, url, error) => const LoadingShimmer(),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class LoadingShimmer extends StatelessWidget {
//   const LoadingShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300.withOpacity(.5),
//       highlightColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 15, bottom: 15),
//             width: MediaQuery.sizeOf(context).width,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(13),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               right: 50,
//               top: 5,
//               left: 15,
//               bottom: 15,
//             ),
//             width: MediaQuery.sizeOf(context).width,
//             height: 20,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(13),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               right: 70,
//               top: 5,
//               left: 15,
//               bottom: 15,
//             ),
//             width: MediaQuery.sizeOf(context).width,
//             height: 20,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(13),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:data/shopping/models/hamper_banner_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shop/hampers/ui/hamper_stack.dart';

// class OverviewBannerCarousel extends StatelessWidget {
//   const OverviewBannerCarousel({
//     super.key,
//     required this.interval,
//     this.hamperBanner,
//     required this.onBannerTap,
//   });

//   final Duration interval;
//   final List<HamperBannerDetail?>? hamperBanner;
//   final Function(String url) onBannerTap;

//   @override
//   Widget build(BuildContext context) {
//     if (hamperBanner == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return FlutterCarousel(
//       options: CarouselOptions(
//         height: 270,
//         showIndicator: false,
//         autoPlay: true,
//         enableInfiniteScroll: true,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         autoPlayInterval: interval,
//         autoPlayAnimationDuration: const Duration(seconds: 1),
//         pauseAutoPlayOnTouch: true,
//         pauseAutoPlayOnManualNavigate: true,
//         slideIndicator: SequentialFillIndicator(),
//       ),
//       items: hamperBanner!.content.map((hamperContent) {
//         print('Rendering hamper content: $hamperContent');
//         return GestureDetector(
//           onTap: () {
//             onBannerTap(hamperContent.baseImage);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: HamperImageStack(
//               imgUrl: hamperContent.baseImage,
//               hamperGifUrl1: hamperContent.gif1,
//               hamperGifUrl2: hamperContent.gif2,
//               hamperCode: hamperBanner!.hamperCode,
//               hamperPrice: hamperBanner!.value,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

class OverviewBannerCarousel extends StatelessWidget {
  const OverviewBannerCarousel({
    super.key,
    required this.interval,
    this.hamperBanner,
    required this.onBannerTap,
  });

  final Duration interval;
  final List<HamperBannerDetail>? hamperBanner;
  final Function(String url) onBannerTap;

  @override
  Widget build(BuildContext context) {
    if (hamperBanner == null || hamperBanner!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: 270,
        showIndicator: false,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: interval,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
        slideIndicator: SequentialFillIndicator(),
      ),
      items: hamperBanner!.map((hamperContent) {
      
        return GestureDetector(
          onTap: () {
            onBannerTap(hamperContent.baseImage);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: HamperImageStack(
              imgUrl: hamperContent.baseImage,
              hamperGifUrl1: hamperContent.gif1,
              hamperGifUrl2: hamperContent.gif2,
              hamperCode: hamperContent.code,
              hamperPrice: hamperContent.value,
              profitpercentage: hamperContent.profitPercentage,
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
