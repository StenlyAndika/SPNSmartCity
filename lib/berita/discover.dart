import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/read.dart';
import 'package:smartcity/widgets/image_container.dart';

import '../data_provider/data_provider.dart';
import '../models/berita_model.dart';
import '../widgets/bottom_nav_bar.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(index: 1),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: const [
          JelajahiBerita(),
        ],
      ),
    );
  }
}

class JelajahiBerita extends ConsumerWidget {
  const JelajahiBerita({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(beritaDataProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jelajahi',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 5),
        Text(
          'Berita dalam kota sungai penuh',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Cari',
            fillColor: Colors.grey.shade200,
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.tune, color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: data.when(
            data: (data) {
              List<BeritaModel> beritaList = data.map((e) => e).toList();
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: beritaList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReadScreen(
                            e: beritaList[index],
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          ImageContainer(
                            width: 80,
                            height: 80,
                            margin:
                                const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            borderRadius: 5,
                            imageUrl:
                                "http://sungaipenuhkota.go.id/storage/${beritaList[index].gambar}",
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  beritaList[index].judul,
                                  maxLines: 3,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${DateTime.now().difference(DateTime.parse(beritaList[index].created_at)).inHours} Jam yang lalu',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      beritaList[index].nama,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            error: (err, s) => Text("error: $err"),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
