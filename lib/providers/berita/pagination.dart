import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:smartcity/models/berita/model_data.dart';

import '../../constants/constants.dart';

class BeritaState {
  final bool isLoading;
  final BeritaModel beritaModel;
  final int? page;
  final bool? hasMoreData;

  BeritaState({
    this.isLoading = true,
    required this.beritaModel,
    this.page,
    this.hasMoreData,
  });

  BeritaState copyWith(
      {bool? isLoading,
      BeritaModel? beritaModel,
      int? page,
      bool? hasMoreData}) {
    return BeritaState(
      isLoading: isLoading ?? this.isLoading,
      beritaModel: beritaModel ?? this.beritaModel,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class BeritaPageNotifier extends StateNotifier<BeritaState> {
  BeritaPageNotifier()
      : super(BeritaState(
          beritaModel: BeritaModel(payload: Payload(data: [])),
          isLoading: true,
        )) {
    loadBerita();
  }

  loadBerita() async {
    state = state.copyWith(isLoading: true);
    final response = await http.get(Uri.parse('${ApiUrls.beritaUrl}berita'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          beritaModel: berita, isLoading: false, page: 1, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  loadMoreBerita() async {
    final currentPage = state.page ?? 1;
    final nextPage = currentPage + 1;
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita?page=$nextPage'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
        isLoading: false,
        beritaModel: BeritaModel(
          payload: Payload(
            data: [
              ...?state.beritaModel.payload!.data,
              ...?berita.payload!.data
            ],
          ),
        ),
        page: nextPage,
        hasMoreData: true,
      );
    } else {
      state = state.copyWith(isLoading: false, hasMoreData: false);
    }
  }

  loadSearchedBerita(String title) async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita?search=$title'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          beritaModel: berita, isLoading: false, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

class BeritaCarouselNotifier extends StateNotifier<BeritaState> {
  BeritaCarouselNotifier()
      : super(BeritaState(
            beritaModel: BeritaModel(payload: Payload(data: [])),
            isLoading: true)) {
    loadCarouselBerita();
  }

  loadCarouselBerita() async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita/carousel'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          beritaModel: berita, isLoading: false, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

final beritaPageProvider =
    StateNotifierProvider.autoDispose<BeritaPageNotifier, BeritaState>(
        (ref) => BeritaPageNotifier());

final beritaCarouselProvider =
    StateNotifierProvider<BeritaCarouselNotifier, BeritaState>(
        (ref) => BeritaCarouselNotifier());
