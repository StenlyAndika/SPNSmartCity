import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/berita_model.dart';
import '../services/api_berita_services.dart';

class BeritaState {
  final bool isLoading;
  final BeritaModel beritaModel;

  BeritaState({this.isLoading = true, required this.beritaModel});

  BeritaState copyWith({bool? isLoading, BeritaModel? beritaModel}) {
    return BeritaState(
      isLoading: isLoading ?? this.isLoading,
      beritaModel: beritaModel ?? this.beritaModel,
    );
  }
}

class BeritaNotifier extends StateNotifier<BeritaState> {
  BeritaNotifier()
      : super(BeritaState(
            beritaModel: BeritaModel(payload: []), isLoading: true)) {
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
      : super(BeritaState(
            beritaModel: BeritaModel(payload: []), isLoading: true)) {
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
