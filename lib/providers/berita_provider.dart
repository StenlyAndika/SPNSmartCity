import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartcity/models/berita_model.dart';

import '../services/api_berita_services.dart';

part 'berita_provider.freezed.dart';

@freezed
class BeritaState with _$BeritaState {
  const factory BeritaState({
    @Default(true) bool isLoading,
    required BeritaModel beritaModel,
  }) = _BeritaState;

  const BeritaState._();
}

class BeritaNotifier extends StateNotifier<BeritaState> {
  BeritaNotifier() : super(BeritaState(beritaModel: BeritaModel(payload: []))) {
    loadBerita();
  }

  loadBerita() async {
    state = state.copyWith(isLoading: true);
    final beritaResponse = await ApiBeritaService().allBerita();
    final berita = BeritaModel.fromJson(beritaResponse);
    state = state.copyWith(beritaModel: berita, isLoading: false);
  }

  loadSearchedBerita(String title) async {
    state = state.copyWith(isLoading: true);
    final beritaResponse = await ApiBeritaService().beritaSearch(title);
    final berita = BeritaModel.fromJson(beritaResponse);
    state = state.copyWith(beritaModel: berita, isLoading: false);
  }
}

class BeritaCarouselNotifier extends StateNotifier<BeritaState> {
  BeritaCarouselNotifier()
      : super(BeritaState(beritaModel: BeritaModel(payload: []))) {
    loadCarouselBerita();
  }

  loadCarouselBerita() async {
    state = state.copyWith(isLoading: true);
    final beritaResponse = await ApiBeritaService().carouselBerita();
    final berita = BeritaModel.fromJson(beritaResponse);
    state = state.copyWith(beritaModel: berita, isLoading: false);
  }
}

final beritaProvider =
    StateNotifierProvider.autoDispose<BeritaNotifier, BeritaState>(
        (ref) => BeritaNotifier());
final beritaCarouselProvider =
    StateNotifierProvider<BeritaCarouselNotifier, BeritaState>(
        (ref) => BeritaCarouselNotifier());
