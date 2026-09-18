import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A network image with a consistent loading placeholder and error fallback.
///
/// Wraps [CachedNetworkImage] so a null/empty or failed-to-load URL never
/// renders a broken-image icon — it falls back to [placeholderAsset]
/// instead, matching the pattern already used in [ProductCard].
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderAsset = 'assets/images/no-photo.png',
    this.placeholderColor = Colors.grey,
    this.borderRadius,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String placeholderAsset;
  final Color placeholderColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    final Widget image = (url == null || url.isEmpty)
        ? _placeholder()
        : CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => _placeholder(),
            errorWidget: (context, url, error) => _error(),
          );

    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }

  Widget _placeholder() {
    return Image.asset(
      placeholderAsset,
      width: width,
      height: height,
      fit: BoxFit.contain,
      color: placeholderColor,
    );
  }

  Widget _error() {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Icon(Icons.error_outline, color: placeholderColor),
      ),
    );
  }
}
