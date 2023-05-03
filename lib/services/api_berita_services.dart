import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class ApiBeritaService {
  Future<dynamic> carouselBerita() async {
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita-carousel'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load berita carousel');
    }
  }

  Future<dynamic> allBerita() async {
    final response = await http.get(Uri.parse('${ApiUrls.beritaUrl}berita'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  Future<dynamic> beritaSearch(String title) async {
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita?search=$title'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search berita');
    }
  }
}
