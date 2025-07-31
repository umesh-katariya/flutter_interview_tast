import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageType { asset, file, url, svg }

class CommonImageView extends StatelessWidget {
  final String? path;
  final ImageType type;
  final double? height, width;
  final String? placeHolderImagePath;
  final BoxFit? fit;
  final Color? color;

  const CommonImageView({
    super.key,
    required this.path,
    required this.type,
    this.height,
    this.width,
    this.placeHolderImagePath,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ImageType.asset:
        try {
          return Image.asset(
            path!,
            height: height,
            width: width,
            fit: fit,
            color: color,
            opacity: const AlwaysStoppedAnimation(1),
          );
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }

      case ImageType.svg:
        try {
          return SvgPicture.asset(
            path!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null ? ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn) : null,
          );
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }

      case ImageType.file:
        try {
          File f = File(path!);
          if (f.existsSync()) {
            return Image.file(
              f,
              height: height,
              width: width,
              fit: fit,
              opacity: const AlwaysStoppedAnimation(1),
            );
          } else {
            return placeHolder(height, width, placeHolderImagePath, fit);
          }
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }

      case ImageType.url:
        try {
          return CachedNetworkImage(
            imageUrl: path ?? "",
            errorWidget: (context, url, error) {
              return placeHolder(height, width, placeHolderImagePath, fit);
            },
            height: height,
            width: width,
            fit: fit,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: fit),
                ),
              );
            },
            placeholderFadeInDuration: const Duration(milliseconds: 500),
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.blue,
                ),
              );
            },
          );
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
    }
  }

  Widget placeHolder(double? height, double? width, String? placeHolderImagePath, BoxFit? fit) {
    return SvgPicture.asset(
      placeHolderImagePath ?? "",
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }
}
