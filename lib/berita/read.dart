import 'package:flutter/material.dart';
import 'package:smartcity/widgets/image_container.dart';

import '../models/berita_model.dart';
import '../widgets/custom_tag.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({Key? key, required this.e}) : super(key: key);
  final BeritaModel e;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: double.infinity,
      imageUrl: "http://sungaipenuhkota.go.id/storage/${e.gambar}",
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            NewsHeadline(
              tgl:
                  '${DateTime.parse(e.created_at).day.toString().padLeft(2, '0')}-${DateTime.parse(e.created_at).month.toString().padLeft(2, '0')}-${DateTime.parse(e.created_at).year}',
              judul: e.judul,
            ),
            NewsBody(e: e),
          ],
        ),
      ),
    );
  }
}

class NewsBody extends StatelessWidget {
  const NewsBody({
    Key? key,
    required this.e,
  }) : super(key: key);

  final BeritaModel e;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomTag(
                  backgroundColor: Colors.black,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      e.nama,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                CustomTag(
                  backgroundColor: Colors.grey,
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${DateTime.now().difference(DateTime.parse(e.created_at)).inHours} Jam yang lalu',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            e.judul,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, height: 1.25),
          ),
          const SizedBox(height: 10),
          Text(
            e.isi
                .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '')
                .replaceAll('&quot;', '"'),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class NewsHeadline extends StatelessWidget {
  const NewsHeadline({Key? key, required this.judul, required this.tgl})
      : super(key: key);
  final String judul;
  final String tgl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                tgl,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            judul,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
        ],
      ),
    );
  }
}
