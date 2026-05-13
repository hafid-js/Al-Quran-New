import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class URoundedImage extends StatelessWidget {
  const URoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = 16,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.isEmpty) {
      return const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
      );
    }

    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        errorWidget: (_, __, ___) => const Icon(
          Icons.broken_image,
          color: Colors.grey,
        ),
      );
    }

    return Image.asset(
      imageUrl,
      fit: fit,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.broken_image,
        color: Colors.grey,
      ),
    );
  }
}
