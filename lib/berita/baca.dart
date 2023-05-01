import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/berita_model.dart';
import '../widgets/custom_tag.dart';
import '../widgets/reusable_widgets.dart';

class BacaBerita extends StatelessWidget {
  final Payload e;
  const BacaBerita({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900.withOpacity(0.9),
              Colors.blue,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: ListView(
          children: [
            NewsHeadline(
              tgl:
                  '${DateTime.parse(e.createdAt.toString()).day.toString().padLeft(2, '0')}-${DateTime.parse(e.createdAt.toString()).month.toString().padLeft(2, '0')}-${DateTime.parse(e.createdAt.toString()).year}',
              judul: e.judul.toString(),
              nama: e.nama.toString(),
              createdAt: e.createdAt.toString(),
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

  final Payload e;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(50)),
            child: CachedNetworkImage(
              imageUrl: 'https://sungaipenuhkota.go.id/storage/${e.gambar}',
              errorWidget: (context, string, _) {
                return const Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            e.isi
                .toString()
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
  const NewsHeadline({
    Key? key,
    required this.judul,
    required this.tgl,
    required this.nama,
    required this.createdAt,
  }) : super(key: key);
  final String judul;
  final String tgl;
  final String nama;
  final String createdAt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(150),
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    nama,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(150),
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ReusableWidgets.time_passed(
                        DateTime.parse(createdAt.toString()),
                        full: false),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
