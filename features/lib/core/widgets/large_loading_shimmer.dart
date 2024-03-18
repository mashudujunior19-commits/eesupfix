import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LargeLoadingShimmer extends StatelessWidget {
  const LargeLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
