import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/berita_model.dart';
import '../../providers/berita_provider.dart';
import '../../widgets/image_carousel.dart';
import '../../widgets/reusable_widgets.dart';
import 'baca.dart';

class Berita extends ConsumerWidget {
  const Berita({Key? key}) : super(key: key);

  static const nameRoute = '/berita';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BeritaModel berita = ref.watch(beritaProvider).beritaModel;
    bool isLoading = ref.watch(beritaProvider).isLoading;

    BeritaModel beritaCarousel = ref.watch(beritaCarouselProvider).beritaModel;
    bool isCarouselLoading = ref.watch(beritaCarouselProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffE0E7FF),
                Colors.white,
              ],
              begin: FractionalOffset(0.0, 0.4),
              end: Alignment.topLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berita',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
                Text(
                  'Dalam kota sungai penuh',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                isCarouselLoading
                    ? const ImageCarouselSkeleton()
                    : CarouselSlider.builder(
                        itemCount: beritaCarousel.payload!.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return ImageCarousel(
                            borderRadius: 10,
                            width: double.infinity,
                            height: double.infinity,
                            imageUrl:
                                "http://sungaipenuhkota.go.id/storage/${beritaCarousel.payload![index].gambar}",
                            timepass:
                                '${DateTime.parse(beritaCarousel.payload![index].createdAt.toString()).day.toString().padLeft(2, '0')}-${DateTime.parse(beritaCarousel.payload![index].createdAt.toString()).month.toString().padLeft(2, '0')}-${DateTime.parse(beritaCarousel.payload![index].createdAt.toString()).year}',
                            berita: beritaCarousel.payload![index],
                            judul:
                                beritaCarousel.payload![index].judul.toString(),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.vertical,
                          viewportFraction: 1.0,
                        ),
                      ),
                const SizedBox(height: 10),
                const SearchField(),
                isLoading
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return const CardBeritaSkeleton();
                          },
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: berita.payload!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return CardBerita(berita: berita.payload![index]);
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardBeritaSkeleton extends StatelessWidget {
  const CardBeritaSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            const Skeleton(
              width: 130,
              height: 130,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(
                      width: 80,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageCarouselSkeleton extends StatelessWidget {
  const ImageCarouselSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Skeleton(
                width: 100,
                height: 25,
              ),
              SizedBox(height: 5),
              Skeleton(
                width: double.infinity,
                height: 30,
              ),
              SizedBox(height: 5),
              Skeleton(
                width: double.infinity,
                height: 30,
              ),
              SizedBox(height: 5),
              Skeleton(
                width: 250,
                height: 30,
              ),
              SizedBox(height: 5),
              Skeleton(
                width: 150,
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}

class CardBerita extends StatelessWidget {
  final Payload berita;
  const CardBerita({Key? key, required this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, BacaBerita.nameRoute, arguments: berita),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 0.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl:
                    'https://sungaipenuhkota.go.id/storage/${berita.gambar}',
                errorWidget: (context, string, _) {
                  return const Icon(Icons.error);
                },
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ReusableWidgets.time_passed(
                          DateTime.parse(berita.createdAt.toString()),
                          full: false),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      berita.judul.toString(),
                      maxLines: 5,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchField extends ConsumerWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Debouncer debouncer = Debouncer();
    return TextField(
      onChanged: (value) {
        debouncer.run(() {
          if (value.isNotEmpty) {
            ref.read(beritaProvider.notifier).loadSearchedBerita(value);
          } else {
            ref.read(beritaProvider.notifier).loadBerita();
          }
        });
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Cari Berita',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)),
    );
  }
}

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
