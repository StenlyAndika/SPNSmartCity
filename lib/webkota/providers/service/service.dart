import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_webkota.dart';
import '../../models/service/model_service.dart';

class ServiceState {
  final bool isLoading;
  final ServiceModel modelService;
  final int? page;
  final bool? hasMoreData;

  ServiceState({
    this.isLoading = true,
    required this.modelService,
    this.page,
    this.hasMoreData,
  });

  ServiceState copyWith(
      {bool? isLoading, ServiceModel? modelService, int? page, bool? hasMoreData}) {
    return ServiceState(
      isLoading: isLoading ?? this.isLoading,
      modelService: modelService ?? this.modelService,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class ServicePageNotifier extends StateNotifier<ServiceState> {
  ServicePageNotifier()
      : super(ServiceState(
          modelService: ServiceModel(payload: Payload(data: [])),
          isLoading: true,
        )) {
    loadService();
  }

  loadService() async {
    state = state.copyWith(isLoading: true);
    final response = await http.get(Uri.parse('${ApiUrls.spnUrl}service'));
    if (response.statusCode == 200) {
      final service = ServiceModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
          modelService: service, isLoading: false, page: 1, hasMoreData: true);
    } else {
      throw Exception('Failed to load all service');
    }
  }

  loadMoreService() async {
    final currentPage = state.page ?? 1;
    final nextPage = currentPage + 1;
    final response =
        await http.get(Uri.parse('${ApiUrls.spnUrl}service?page=$nextPage'));
    if (response.statusCode == 200) {
      final service = ServiceModel.fromJson(jsonDecode(response.body));
      state = state.copyWith(
        isLoading: false,
        modelService: ServiceModel(
          payload: Payload(
            data: [...?state.modelService.payload!.data, ...?service.payload!.data],
          ),
        ),
        page: nextPage,
        hasMoreData: true,
      );
    } else {
      state = state.copyWith(isLoading: false, hasMoreData: false);
    }
  }

}

final serviceProvider =
    StateNotifierProvider<ServicePageNotifier, ServiceState>(
        (ref) => ServicePageNotifier());
