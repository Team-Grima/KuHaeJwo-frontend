import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/common/common.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({Key? key, required this.url, this.width, this.height, this.loadingWidth, this.loadingHeight}) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final double? loadingWidth;
  final double? loadingHeight;

  @override
  Widget build(BuildContext context) {
    if (url == "" || url == "") {
      return SizedBox(width: width, height: height);
    } else {
      return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: BoxFit.fill,
          placeholder: (context, url) => SizedBox(
                width: width,
                height: height,
                child: Shimmer.fromColors(
                  baseColor: CommonColor.gray05,
                  highlightColor: CommonColor.gray01,
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.white,
                  ),
                ),
              ),
          errorWidget: (context, url, error) => Image.asset("assets/images/error_image.jpg", width: width, height: height, fit: BoxFit.fill));
    }
  }
}
