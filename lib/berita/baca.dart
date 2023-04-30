import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcity/widgets/image_container.dart';

import '../models/berita_model.dart';

class Baca extends StatelessWidget {
  const Baca({Key? key, required this.e}) : super(key: key);
  final BeritaModel e;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: double.infinity,
      imageUrl: e.gambar,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
