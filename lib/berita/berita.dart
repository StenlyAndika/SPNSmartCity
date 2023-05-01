import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/baca.dart';

import '../models/berita_model.dart';
import '../providers/berita_provider.dart';
import '../widgets/reusable_widgets.dart';

class Berita extends ConsumerWidget {
  const Berita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BeritaModel berita = ref.watch(beritaProvider).beritaModel;
    bool isLoading = ref.watch(beritaProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            const SearchField(),
            isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
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
    );
  }
}

class CardBerita extends StatelessWidget {
  final Payload berita;
  const CardBerita({Key? key, required this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => BacaBerita(
            e: berita,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                    maxLines: 6,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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

class SearchField extends ConsumerWidget {
  const SearchField({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Debouncer debouncer = Debouncer();
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
            )
          ]
        ),
        child: TextField(
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
              hintText: 'Search News',
              hintStyle: const TextStyle(
                  color: Color(0xffDDDADA),
                  fontSize: 14
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
                )
          ),
        ),
    );
  }
}

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds=500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}