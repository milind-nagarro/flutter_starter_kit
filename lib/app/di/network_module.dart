import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:fab_nhl/app/di/json_serializable_converter.dart';
import 'package:fab_nhl/data/remote/response/article_response.dart';
import 'package:fab_nhl/data/remote/service/article_service.dart';
import 'package:get_it/get_it.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

const _articlesBaseUrl = "https://api.nytimes.com/svc/";
const articlesApiKey = "qtVlLSfH968rf6nd2tqbLPDnHnA7NLEb";

// map of network response entity class type and its factory
// used for data serialization
const Map<Type, JsonFactory> _networkEntityJsonFactories = {
  ArticleResponse: ArticleResponse.fromJsonFactory,
};

abstract class NetworkModule {
  static void init(GetIt locator) {
    // init chopper client
    locator.registerLazySingleton(() => ChopperClient(
        baseUrl: _articlesBaseUrl,
        converter: const JsonSerializableConverter(_networkEntityJsonFactories),
        interceptors: kDebugMode ? [HttpLoggingInterceptor()] : []));

    // init network services
    locator
        .registerFactory(() => ArticleService.create(locator<ChopperClient>()));
  }
}
