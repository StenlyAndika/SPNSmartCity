import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:smartcity/models/berita_model.dart';

class ApiServices {
  String endpoint = 'https://sungaipenuhkota.go.id/api/berita?page=1';

  Future<List<BeritaModel>> getAllBerita() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['payload']['data'];
      return result.map(((e) => BeritaModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final beritaProvider = Provider<ApiServices>((ref) => ApiServices());
