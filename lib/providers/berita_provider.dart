import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/berita_model.dart';

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

class BeritaCarouselNotifier extends StateNotifier<BeritaState> {
  BeritaCarouselNotifier()
      : super(BeritaState(
            beritaModel: BeritaModel(payload: []), isLoading: true)) {
    loadCarouselBerita();
  }

  loadCarouselBerita() async {
    state = state.copyWith(isLoading: true);
    final response =
        await http.get(Uri.parse('${ApiUrls.beritaUrl}berita/carousel'));
    if (response.statusCode == 200) {
      final berita = BeritaModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(beritaModel: berita, isLoading: false);
    } else {
      throw Exception('Failed to load all berita');
    }
  }
}

final beritaCarouselProvider =
    StateNotifierProvider<BeritaCarouselNotifier, BeritaState>(
        (ref) => BeritaCarouselNotifier());
