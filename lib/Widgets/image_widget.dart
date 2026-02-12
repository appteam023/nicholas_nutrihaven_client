import 'package:flutter/material.dart';
import '../Data/DataSources/remote/api_constant.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? scale;
  final BoxFit? fit;
  final bool isNetworkImage;
  final double? height;
  final double? width;
  final Color? color;

  const ImageWidget({
    super.key,
    this.isNetworkImage = false,
    required this.imageUrl,
    this.scale,
    this.height,
    this.width,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Image.network(
        imageUrl.startsWith("http")
            ? imageUrl
            : ApiConstants.baseUrl + imageUrl,
        height: height,
        width: width,
        color: color,
        fit: fit ?? BoxFit.cover,
        scale: scale ?? 1,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('error in image widget: \n $error + $imageUrl}');
          return SizedBox(
            height: height,
            width: width,
            child: Material(
              color: color ?? Colors.grey.withValues(alpha: 0.1),
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.grey,
              ),
            ),
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: CircularProgressIndicator.adaptive(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
        },
      );
    }
    return Image.asset(
      imageUrl,
      color: color,
      fit: BoxFit.cover,
      scale: scale ?? 1,
      errorBuilder: (context, error, stackTrace) => Material(
        color: Colors.grey.withValues(alpha: 0.1),
      ),
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? scale;
  final bool? isNetworkImage;
  final double height;
  final double width;
  final Color? color;

  const ProfileImageWidget({
    super.key,
    this.isNetworkImage = false,
    this.imageUrl,
    this.scale,
    this.height = 204,
    this.width = 182,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage!) {
      return Image.network(
        imageUrl!,
        height: height,
        width: width,
        fit: BoxFit.cover,
        scale: scale ?? 1,
        errorBuilder: (context, error, stackTrace) => Material(
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Center(
            child: Icon(
              Icons.person,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator.adaptive(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
        },
      );
    }
    return Image.asset(
      imageUrl!,
      color: color,
      fit: BoxFit.cover,
      scale: scale ?? 1,
      errorBuilder: (context, error, stackTrace) => Material(
        color: Colors.grey.withValues(alpha: 0.1),
        child: const Center(
          child: Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }
}
