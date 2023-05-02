import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/berita.dart';

import '../models/berita_model.dart';
import '../providers/berita_provider.dart';
import '../widgets/image_carousel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    BeritaModel berita = ref.watch(beritaCarouselProvider).beritaModel;
    bool isLoading = ref.watch(beritaCarouselProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat datang',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              'Sungai Penuh',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 5),
            Text(
              'Smart Society',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Berita',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Berita()),
                    );
                  },
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CarouselSlider.builder(
                    itemCount: berita.payload!.length,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      return ImageCarousel(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        imageUrl:
                            "http://sungaipenuhkota.go.id/storage/${berita.payload![index].gambar}",
                        timepass:
                            '${DateTime.parse(berita.payload![index].createdAt.toString()).day.toString().padLeft(2, '0')}-${DateTime.parse(berita.payload![index].createdAt.toString()).month.toString().padLeft(2, '0')}-${DateTime.parse(berita.payload![index].createdAt.toString()).year}',
                        berita: berita.payload![index],
                        judul: berita.payload![index].judul.toString(),
                      );
                    },
                    options: CarouselOptions(
                      height: 225,
                      autoPlay: true,
                      viewportFraction: 1.0,
                    ),
                  ),
            const SizedBox(height: 20),
            const Text(
              'Katalog Layanan',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  berita.payload!.length,
                  (index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage("img/avatar.png"),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xff1D1617).withOpacity(0.25),
                                blurRadius: 5,
                                spreadRadius: 0.0)
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(berita.payload![index].nama.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
