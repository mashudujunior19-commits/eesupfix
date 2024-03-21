import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_sources/eesupools/models/media_file.dart';
import 'package:flutter/material.dart';

class ChatMediaFiles extends StatelessWidget {
  const ChatMediaFiles({super.key, this.mediaFiles});
  final List<MediaFile>? mediaFiles;

  @override
  Widget build(BuildContext context) {
    if (mediaFiles == null) return const SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          mediaFiles!.length,
          (index) => Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            child: CachedNetworkImage(
              imageUrl: mediaFiles![index].url,
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
