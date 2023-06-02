import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../widgets/reusable_widgets.dart';


class BacaBerita extends StatelessWidget {
  final dynamic e;
  const BacaBerita({Key? key, required this.e}) : super(key: key);

  static const nameRoute = '/bacaberita';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFEDECF2),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Hero(
              tag: e.gambar,
              child: CachedNetworkImage(
                imageUrl: 'https://sungaipenuhkota.go.id/storage/${e.gambar}',
                errorWidget: (context, string, _) {
                  return const Icon(Icons.error);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.judul,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  e.nama +
                      " - " +
                      ReusableWidgets.time_passed(
                          DateTime.parse(e.createdAt.toString()),
                          full: false),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
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
          )
        ],
      ),
    );
  }
}
