import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:smartcity/models/berita_page_model.dart';
import '../constants/constants.dart';

class BeritaPageState {
  final bool isLoading;
  final BeritaPageModel beritaModelPage;

  BeritaPageState({this.isLoading = true, required this.beritaModelPage});

  BeritaPageState copyWith({bool? isLoading, BeritaPageModel? beritaModelPage}) {
    return BeritaPageState(
      isLoading: isLoading ?? this.isLoading,
      beritaModelPage: beritaModelPage ?? this.beritaModelPage,
    );
  }
}

class BeritaPageNotifier extends StateNotifier<BeritaPageState> {
  BeritaPageNotifier()
      : super(BeritaPageState(
            beritaModelPage: BeritaPageModel(payload: Payload(data: [])), isLoading: true)) {
    loadBerita();
  }

  loadBerita() async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita/paginated'));
    if (response.statusCode == 200) {
      final berita = BeritaPageModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(beritaModelPage: berita, isLoading: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  loadSearchedBerita(String title) async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita/paginated?search=$title'));
    if (response.statusCode == 200) {
      final berita = BeritaPageModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(beritaModelPage: berita, isLoading: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

final beritaPageProvider =
    StateNotifierProvider.autoDispose<BeritaPageNotifier, BeritaPageState>(
        (ref) => BeritaPageNotifier());