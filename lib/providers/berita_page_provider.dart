import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:smartcity/models/berita_page_model.dart';
import '../constants/constants.dart';

class BeritaPageState {
  final bool isLoading;
  final BeritaPageModel beritaModelPage;
  final int page;
  final bool hasMoreData;

  BeritaPageState({
    this.isLoading = true,
    required this.beritaModelPage,
    required this.page,
    required this.hasMoreData,
  });

  BeritaPageState copyWith(
      {bool? isLoading,
      BeritaPageModel? beritaModelPage,
      int? page,
      bool? hasMoreData}) {
    return BeritaPageState(
      isLoading: isLoading ?? this.isLoading,
      beritaModelPage: beritaModelPage ?? this.beritaModelPage,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class BeritaPageNotifier extends StateNotifier<BeritaPageState> {
  BeritaPageNotifier()
      : super(BeritaPageState(
          beritaModelPage: BeritaPageModel(payload: Payload(data: [])),
          isLoading: true,
          page: 1,
          hasMoreData: true,
        )) {
    loadBerita();
  }

  loadBerita() async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita/paginated'));
    if (response.statusCode == 200) {
      final berita = BeritaPageModel.fromJson(jsonDecode(response.body));
      state =
          state.copyWith(beritaModelPage: berita, isLoading: false, page: 1);
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  loadMoreBerita(int page) async {
    final response = await http
        .get(Uri.parse('${ApiUrls.beritaUrl}berita/paginated?page=$page'));
    if (response.statusCode == 200) {
      final berita = BeritaPageModel.fromJson(jsonDecode(response.body));
      if (berita.payload!.data!.isEmpty) {
        state = state.copyWith(isLoading: false, hasMoreData: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          beritaModelPage: BeritaPageModel(
            payload: Payload(
              data: [
                ...?state.beritaModelPage.payload!.data,
                ...?berita.payload!.data
              ],
            ),
          ),
          page: page + 1,
        );
      }
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  loadSearchedBerita(String title) async {
    state = state.copyWith(isLoading: true);
    final response = await http
        .get(Uri.parse('${ApiUrls.beritaUrl}berita/paginated?search=$title'));
    if (response.statusCode == 200) {
      final berita = BeritaPageModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          beritaModelPage: berita, isLoading: false, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

final beritaPageProvider =
    StateNotifierProvider.autoDispose<BeritaPageNotifier, BeritaPageState>(
        (ref) => BeritaPageNotifier());
