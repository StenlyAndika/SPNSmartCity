import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/read.dart';
import 'package:smartcity/data_provider/data_provider.dart';
import 'package:smartcity/widgets/custom_tag.dart';
import 'package:smartcity/widgets/image_carousel.dart';

import '../models/berita_model.dart';
import 'discover.dart';

class Berita extends ConsumerWidget {
  const Berita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(beritaDataProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFfbfcff),
      body: data.when(
        data: (data) {
          List<BeritaModel> beritaList = data.map((e) => e).toList();
          return Column(
            children: [
              BeritaCarousel(beritaList: beritaList),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: const [
                    Text(
                      'Smart Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      beritaList.length,
                      (index) {
                        BeritaModel berita = beritaList[index];
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage("img/avatar.png"),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(5, 5),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(-5, -5),
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(berita.nama),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text("error: $err"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class BeritaCarousel extends StatelessWidget {
  const BeritaCarousel({
    Key? key,
    required this.beritaList,
  }) : super(key: key);

  final List<BeritaModel> beritaList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat datang',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 50),
          Text(
            'Telusuri',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
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
                    MaterialPageRoute(builder: (context) => const Discover()),
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
          CarouselSlider.builder(
            itemCount: beritaList.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(80.0),
                ),
              ),
              child: ImageCarousel(
                width: double.infinity,
                imageUrl:
                    "http://sungaipenuhkota.go.id/storage/${beritaList[index].gambar}",
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
                            '${DateTime.parse(beritaList[index].created_at).day.toString().padLeft(2, '0')}-${DateTime.parse(beritaList[index].created_at).month.toString().padLeft(2, '0')}-${DateTime.parse(beritaList[index].created_at).year}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        beritaList[index].judul,
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ReadScreen(
                                e: beritaList[index],
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Row(
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              height: 225,
              autoPlay: true,
              viewportFraction: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
