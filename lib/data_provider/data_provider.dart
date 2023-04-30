import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/models/berita_model.dart';
import 'package:smartcity/services/services.dart';

final beritaDataProvider = FutureProvider<List<BeritaModel>>((ref) async {
  return ref.watch(beritaProvider).getAllBerita();
});
