// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ArticleService extends ArticleService {
  _$ArticleService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ArticleService;

  @override
  Future<Response<ArticleResponse>> getArticles() {
    final $url =
        'mostpopular/v2/mostviewed/all-sections/7.json?api-key=qtVlLSfH968rf6nd2tqbLPDnHnA7NLEb';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ArticleResponse, ArticleResponse>($request);
  }
}
