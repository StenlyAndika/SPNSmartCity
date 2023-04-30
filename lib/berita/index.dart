import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/read.dart';
import 'package:smartcity/data_provider/data_provider.dart';
import 'package:smartcity/widgets/custom_tag.dart';

import '../models/berita_model.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/image_container.dart';

class Berita extends ConsumerWidget {
  const Berita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(beritaDataProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(index: 0),
      extendBodyBehindAppBar: true,
      body: data.when(
        data: (data) {
          List<BeritaModel> beritaList = data.map((e) => e).toList();
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              BeritaUtama(beritaList: beritaList),
              BeritaTerkini(beritaList: beritaList),
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

class BeritaTerkini extends StatelessWidget {
  const BeritaTerkini({
    Key? key,
    required this.beritaList,
  }) : super(key: key);

  final List<BeritaModel> beritaList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Berita Terkini',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
              ),
              Text('Selengkapnya',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: beritaList.length,
              itemBuilder: (_, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReadScreen(
                          e: beritaList[index],
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                          width: MediaQuery.of(context).size.width * 0.5,
                          imageUrl:
                              "http://sungaipenuhkota.go.id/storage/${beritaList[index].gambar}",
                        ),
                        const SizedBox(height: 5.0),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ReadScreen(
                                e: beritaList[index],
                              ),
                            ),
                          ),
                          child: Text(
                            beritaList[index].judul,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, height: 1.5),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '${DateTime.now().difference(DateTime.parse(beritaList[index].created_at)).inHours} Jam yang lalu',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'oleh : ${beritaList[index].nama}',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class BeritaUtama extends StatelessWidget {
  const BeritaUtama({
    Key? key,
    required this.beritaList,
  }) : super(key: key);

  final List<BeritaModel> beritaList;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      imageUrl: "http://sungaipenuhkota.go.id/storage/${beritaList[0].gambar}",
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(
              backgroundColor: Colors.grey.withAlpha(150),
              children: [
                Text(
                  'Berita terbaru',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              beritaList[0].judul,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReadScreen(
                      e: beritaList[0],
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Row(
                children: [
                  Text(
                    'Baca selengkapnya',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w900),
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
    );
  }
}
