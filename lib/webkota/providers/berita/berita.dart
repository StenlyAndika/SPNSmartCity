import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_webkota.dart';
import '../../models/berita/model_data.dart';

class BeritaState {
  final bool isLoading;
  final BeritaModel modelBerita;
  final int? page;
  final bool? hasMoreData;

  BeritaState({
    this.isLoading = true,
    required this.modelBerita,
    this.page,
    this.hasMoreData,
  });

  BeritaState copyWith(
      {bool? isLoading,
      BeritaModel? modelBerita,
      int? page,
      bool? hasMoreData}) {
    return BeritaState(
      isLoading: isLoading ?? this.isLoading,
      modelBerita: modelBerita ?? this.modelBerita,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class BeritaPageNotifier extends StateNotifier<BeritaState> {
  BeritaPageNotifier()
      : super(BeritaState(
          modelBerita: BeritaModel(payload: Payload(data: [])),
          isLoading: true,
        )) {
    loadBerita();
  }

  loadBerita() async {
    state = state.copyWith(isLoading: true);
    final response = await http.get(Uri.parse('${ApiUrls.spnUrl}berita'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          modelBerita: berita, isLoading: false, page: 1, hasMoreData: true);
    } else {
      throw Exception('Failed to load all berita');
    }
  }

  loadMoreBerita() async {
    final currentPage = state.page ?? 1;
    final nextPage = currentPage + 1;
    final response =
        await http.get(Uri.parse('${ApiUrls.spnUrl}berita?page=$nextPage'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
        isLoading: false,
        modelBerita: BeritaModel(
          payload: Payload(
            data: [
              ...?state.modelBerita.payload!.data,
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
        await http.get(Uri.parse('${ApiUrls.spnUrl}berita?search=$title'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          modelBerita: berita, isLoading: false, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

class BeritaCarouselNotifier extends StateNotifier<BeritaState> {
  BeritaCarouselNotifier()
      : super(BeritaState(
            modelBerita: BeritaModel(payload: Payload(data: [])),
            isLoading: true)) {
    loadCarouselBerita();
  }

  loadCarouselBerita() async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.spnUrl}berita/carousel'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          modelBerita: berita, isLoading: false, hasMoreData: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

final beritaPageProvider =
    StateNotifierProvider<BeritaPageNotifier, BeritaState>(
        (ref) => BeritaPageNotifier());

final beritaCarouselProvider =
    StateNotifierProvider<BeritaCarouselNotifier, BeritaState>(
        (ref) => BeritaCarouselNotifier());
