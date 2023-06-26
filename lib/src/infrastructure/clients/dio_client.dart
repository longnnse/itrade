import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_package;
import 'package:path_provider/path_provider.dart';

import '../../../core/initialize/core_url.dart';
import '../../../core/utils/extensions/hive_key.dart';


class DioITradeClient {
  DioITradeClient._privateConstructor();

  static final DioITradeClient instance =
  DioITradeClient._privateConstructor();

  Dio? _dio;

  Future<Dio> get client async => _dio ??= (await _getClient());

  Future<HiveCacheStore> _getCacheStore() async {
    final cacheDir = await getTemporaryDirectory();
    return HiveCacheStore(
      '${cacheDir.path}/cache/task-manager/',
      hiveBoxName: HiveKeys.apiBoxName,
    );
  }

  Future<Dio> _getClient() async {
    const accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJkMDcyNzNjYy1jZDQ0LTRkODMtODg3My0wNjNjOGM2Mjg4YWEiLCJFbWFpbCI6ImxvbmdubEBmcHQuZWR1LnZuIiwiRnVsbE5hbWUiOiJOZ-G7jWMgTG9uZ05ndXnhu4VuIiwiVXNlck5hbWUiOiJsb25nbmwiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNZW1iZXIiLCJQaG9uZU51bWJlciI6IjA5ODc2NTQzMjEiLCJleHAiOjE2ODc4NTExMzAsImlzcyI6Ik9ubGluZV9NYXJrZXRwbGFjZV9TeXN0ZW0iLCJhdWQiOiJPbmxpbmVfTWFya2V0cGxhY2VfU3lzdGVtIn0.akflO4F-6NjOdT4GiIIHtjqkmbih_pz3UwLRX1th4BM';
    const headers = {'Authorization': 'Bearer $accessToken', 'Accept': '*/*'};
    const isShowLog = true;
    final options = BaseOptions(
        headers: headers,
        baseUrl: CoreUrl.baseURL,
        receiveDataWhenStatusError: true,
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        // 30 seconds
        receiveTimeout: const Duration(seconds: 30) // 30 seconds
        );

    final dio = Dio(options);

    await _getCacheStore().then((cacheStore) {
      var customCacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.refresh,
        hitCacheOnErrorExcept: [401, 404],
        allowPostMethod: false,
      );
      dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
    });
    dio.interceptors.clear();
    if (isShowLog && kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
    }
    return dio;
  }
}
