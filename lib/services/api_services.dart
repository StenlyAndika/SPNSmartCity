import 'dart:convert';

import 'package:http/http.dart';
import 'package:smartcity/config/api_config.dart';
import 'package:smartcity/models/berita_model.dart';

class ApiServices {

  Future<List<BeritaModel>> getAllBerita() async {
    // Response response = await get(Uri.parse('${AppConstants.beritaUrl}?page=$page'));
    Response response = await get(Uri.parse(AppConstants.beritaUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['payload']['data'];
      return result.map(((e) => BeritaModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  
}
