import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/berita_model.dart';
import '../services/api_services.dart';

final apiServiceProviders = Provider<ApiServices>((ref) => ApiServices());

final beritaDataProvider = FutureProvider<List<BeritaModel>>((ref) async {
  return ref.watch(apiServiceProviders).getAllBerita();
});