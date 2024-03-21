import 'package:cached_network_image/cached_network_image.dart';
import 'package:eesup_data_source/eesupools/models/media_file.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldReplyMedia extends ConsumerWidget {
  const TextFieldReplyMedia({super.key, required this.media});
  final List<MediaFile>? media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (media == null) return const SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          media!.length,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 5),
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            child: CachedNetworkImage(
              imageUrl: media![index].url,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Padding(
                padding: const EdgeInsets.all(15),
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) {
                return Text(
                  "Could not load image",
                  style: Theme.of(context).textTheme.displayMedium!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
