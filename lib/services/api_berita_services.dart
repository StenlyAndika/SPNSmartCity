import 'package:dio/dio.dart';

import '../constants/constants.dart';

class ApiBeritaService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: ApiUrls.beritaUrl, responseType: ResponseType.json));

  carouselBerita() async {
    var response = await _dio.get('berita-carousel');
    return response.data;
  }

  allBerita() async {
    var response = await _dio.get('berita');
    return response.data;
  }

  beritaSearch(String title) async {
    var response = await _dio.get('berita?search=$title');
    return response.data;
  }
}
