import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartcity/gpt/views/chat.dart';

import 'webkota/models/berita/model_data.dart';
import 'webkota/providers/berita/berita.dart';
import 'widgets/skeleton.dart';
import 'webkota/views/berita/image_carousel.dart';
import 'webkota/views/berita/index.dart';
import 'webkota/views/pesan/index.dart';
import 'webkota/views/tetris/board.dart';
import 'webkota/views/todo/index.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  static const nameRoute = '/';
  @override
  Widget build(BuildContext context, ref) {
    BeritaModel beritaCarousel = ref.watch(beritaCarouselProvider).modelBerita;
    bool isCarouselLoading = ref.watch(beritaCarouselProvider).isLoading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 65, 180),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sungai Penuh",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Central Service System",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(Pesan.nameRoute),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      const Text(
                        "Berita Terbaru",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 65, 180)),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(Berita.nameRoute),
                        child: const Text(
                          "Selengkapnya",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 3, 65, 180)),
                        ),
                      )
                    ],
                  ),
                ),
                isCarouselLoading
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: ImageCarouselSkeleton(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: CarouselSlider.builder(
                          itemCount: beritaCarousel.payload!.data!.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return ImageCarousel(
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
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 1.0,
                          ),
                        ),
                      ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Kategori Layanan",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 65, 180)),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => "",
                        child: const Text(
                          "Selengkapnya",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 3, 65, 180)),
                        ),
                      )
                    ],
                  ),
                ),
                const GridDashboard(),
              ],
            ),
          ),
        ],
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

class GridDashboard extends StatefulWidget {
  const GridDashboard({Key? key}) : super(key: key);

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  List<Items> item = [
    Items(
        icon: Icons.chat,
        title: "ChatGPT",
        subtitle: "Powered by OpenAI",
        event: ChatScreen.nameRoute,
        image: "assets/gpt/openai_logo.jpg",
        isImage: true),
    Items(
        icon: Icons.work_history,
        title: "Daftar Tugas",
        subtitle: "Mancing, Berenang, Tenggelam",
        event: DaftarTugas.nameRoute,
        image: "",
        isImage: false),
    Items(
        icon: Icons.gamepad,
        title: "Games",
        subtitle: "Tetris",
        event: GameBoard.nameRoute,
        image: "",
        isImage: false),
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
                    data.isImage
                        ? Image.asset(data.image, height: 35, width: 35)
                        : Icon(
                            data.icon,
                            size: 42,
                            color: const Color.fromARGB(255, 3, 65, 180),
                          ),
                    const SizedBox(height: 5),
                    Text(
                      data.title,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 3, 65, 180),
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
  String image;
  bool isImage;
  Items(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.event,
      required this.image,
      required this.isImage});
}
