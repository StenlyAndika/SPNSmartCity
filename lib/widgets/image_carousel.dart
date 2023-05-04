import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../view/berita/baca.dart';
import 'custom_tag.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    Key? key,
    required this.height,
    required this.borderRadius,
    required this.width,
    required this.imageUrl,
    this.padding,
    this.margin,
    required this.timepass,
    this.berita,
    required this.judul,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final String timepass;
  final dynamic berita;
  final String judul;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTag(
                    backgroundColor: Colors.grey.withAlpha(200),
                    children: [
                      Text(
                        timepass,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, BacaBerita.nameRoute,
                          arguments: berita);
                    },
                    child: Column(
                      children: [
                        Text(
                          judul,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Baca selengkapnya',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
