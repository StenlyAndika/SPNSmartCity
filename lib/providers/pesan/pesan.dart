import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/pesan/model_pesan.dart';
import '../../constants/constants.dart';

class PesanState {
  final bool isLoading;
  final PesanModel modelPesan;
  final int? page;
  final bool? hasMoreData;

  PesanState({
    this.isLoading = true,
    required this.modelPesan,
    this.page,
    this.hasMoreData,
  });

  PesanState copyWith(
      {bool? isLoading, PesanModel? modelPesan, int? page, bool? hasMoreData}) {
    return PesanState(
      isLoading: isLoading ?? this.isLoading,
      modelPesan: modelPesan ?? this.modelPesan,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class PesanPageNotifier extends StateNotifier<PesanState> {
  PesanPageNotifier()
      : super(PesanState(
          modelPesan: PesanModel(payload: Payload(data: [])),
          isLoading: true,
        )) {
    loadPesan();
  }

  loadPesan() async {
    state = state.copyWith(isLoading: true);
    final response = await http.get(Uri.parse('${ApiUrls.spnUrl}pesan'));
    if (response.statusCode == 200) {
      final pesan = PesanModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          modelPesan: pesan, isLoading: false, page: 1, hasMoreData: true);
    } else {
      throw Exception('Failed to load all pesan');
    }
  }

  loadMorePesan() async {
    final currentPage = state.page ?? 1;
    final nextPage = currentPage + 1;
    final response =
        await http.get(Uri.parse('${ApiUrls.spnUrl}pesan?page=$nextPage'));
    if (response.statusCode == 200) {
      final pesan = PesanModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
        isLoading: false,
        modelPesan: PesanModel(
          payload: Payload(
            data: [...?state.modelPesan.payload!.data, ...?pesan.payload!.data],
          ),
        ),
        page: nextPage,
        hasMoreData: true,
      );
    } else {
      state = state.copyWith(isLoading: false, hasMoreData: false);
    }
  }

  deletePesan(String id) async {
    state = state.copyWith(isLoading: true);
    final response = await http.delete(Uri.parse('${ApiUrls.spnUrl}pesan/$id'));
    if (response.statusCode == 200) {
      final response = await http.get(Uri.parse('${ApiUrls.spnUrl}pesan'));
      if (response.statusCode == 200) {
        final pesan = PesanModel.fromJson(jsonDecode(response.body));
        state = state.copyWith(
          modelPesan: pesan, isLoading: false, page: 1, hasMoreData: true);
      } else {
        throw Exception('Failed to load all pesan');
      }
    } else {
      throw Exception('Failed to delete pesan');
    }
  }
}

final pesanProvider =
    StateNotifierProvider<PesanPageNotifier, PesanState>(
        (ref) => PesanPageNotifier());
