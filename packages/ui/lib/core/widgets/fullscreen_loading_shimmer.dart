import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenLoadingShimmer extends StatelessWidget {
  const FullScreenLoadingShimmer({
    super.key,
    this.margin,
    this.showPopButton = false,
    this.title,
  });
  final bool showPopButton;
  final EdgeInsets? margin;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPopButton)
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                if (title != null) Text(title!),
                50.sW,
              ],
            ),
          ),
        Padding(
          padding:
              margin ?? const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade50,
            child: Column(
              children: List.generate(
                3,
                (index) => const _ShimmerContainer(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerContainer extends StatelessWidget {
  const _ShimmerContainer();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.only(top: 10),
          width: context.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 20,
          margin: const EdgeInsets.only(top: 10),
          width: context.width * .7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        Container(
          height: 10,
          margin: const EdgeInsets.only(top: 10),
          width: context.width * .6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}
