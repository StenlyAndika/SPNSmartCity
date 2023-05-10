import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/berita/model_data.dart';
import '../providers/berita/berita.dart';
import '../widgets/image_carousel.dart';
import 'berita/berita.dart';
import 'pesan/pesan.dart';

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  static const nameRoute = '/';
  @override
  Widget build(BuildContext context, ref) {
    BeritaModel beritaCarousel = ref.watch(beritaCarouselProvider).modelBerita;
    bool isCarouselLoading = ref.watch(beritaCarouselProvider).isLoading;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffE0E7FF),
              Colors.white,
            ],
            begin: FractionalOffset(1.4, 0.4),
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sungai Penuh",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Smart Service",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color(0xff6DA9E4),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            isCarouselLoading
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: ImageCarouselSkeleton(),
                  )
                : Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: CarouselSlider.builder(
                      itemCount: beritaCarousel.payload!.data!.length,
                      itemBuilder:
                          (BuildContext context, int index, int pageViewIndex) {
                        return ImageCarousel(
                          borderRadius: 10,
                          width: double.infinity,
                          height: double.infinity,
                          imageUrl:
                              "http://sungaipenuhkota.go.id/storage/${beritaCarousel.payload!.data![index].gambar}",
                          timepass:
                              '${DateTime.parse(beritaCarousel.payload!.data![index].createdAt.toString()).day.toString().padLeft(2, '0')}-${DateTime.parse(beritaCarousel.payload!.data![index].createdAt.toString()).month.toString().padLeft(2, '0')}-${DateTime.parse(beritaCarousel.payload!.data![index].createdAt.toString()).year}',
                          berita: beritaCarousel.payload!.data![index],
                          judul: beritaCarousel.payload!.data![index].judul
                              .toString(),
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
                  ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Katalog Layanan",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color(0xff6DA9E4),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const GridDashboard()
          ],
        ),
      ),
    );
  }
}

class GridDashboard extends StatefulWidget {
  const GridDashboard({Key? key}) : super(key: key);

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  List<Items> item = [
    Items(
        icon: Icons.newspaper,
        title: "Berita",
        subtitle: "Hari ini",
        event: Berita.nameRoute),
    Items(
        icon: Icons.message,
        title: "Kotak Masuk",
        subtitle: "Pesan dari warga sekitar",
        event: Pesan.nameRoute),
    Items(
        icon: Icons.food_bank_outlined,
        title: "Jajanan",
        subtitle: "Onde Onde Tempe",
        event: ""),
    Items(
        icon: Icons.location_on_outlined,
        title: "Wisata",
        subtitle: "Cek lokasi wisata terbaru",
        event: ""),
    Items(
        icon: Icons.work_history,
        title: "List Aktivitas",
        subtitle: "Mancing, Berenang, Tenggelam",
        event: ""),
    Items(
        icon: Icons.settings,
        title: "Pengaturan",
        subtitle: "Pengaturan aplikasi",
        event: "")
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 20, right: 20),
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: item.map((data) {
            return InkWell(
              onTap: () => Navigator.of(context).pushNamed(data.event),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff1D1617).withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(data.icon, size: 42),
                    const SizedBox(height: 5),
                    Text(
                      data.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  IconData? icon;
  String title;
  String subtitle;
  String event;
  Items(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.event});
}
