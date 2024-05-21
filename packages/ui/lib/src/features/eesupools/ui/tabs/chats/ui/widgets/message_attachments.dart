import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/image_viewer_dialog.dart';

class MessageAttachments extends StatelessWidget {
  const MessageAttachments({super.key, required this.mediaFiles});
  final List<MediaFile> mediaFiles;

  String _decrypt(String str) {
    // Generate a key
    final key = encrypt.Key.fromBase16(dotenv.get('CHAT_SECRET'));
    final iv = encrypt.IV.fromBase16(dotenv.get('CHAT_SECRET'));
    final decrypter = encrypt.Encrypter(encrypt.AES(key));
    // Encrypt the plain text
    final res = decrypter.decrypt(encrypt.Encrypted.fromBase16(str), iv: iv);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          mediaFiles.length,
          (index) => InkWell(
            onTap: () {
              context.showDialog(
                color: Colors.transparent,
                child: ImageViewerDialog(
                  image: Image.network(
                    _decrypt(mediaFiles[index].url),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: _decrypt(mediaFiles[index].url),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(15),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: context.colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Text(
                    "Could not load image",
                    style: context.textTheme.displayMedium,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
