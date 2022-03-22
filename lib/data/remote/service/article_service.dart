import 'package:chopper/chopper.dart';
import 'package:fab_nhl/app/di/network_module.dart';
import 'package:fab_nhl/data/remote/response/article_response.dart';

part 'article_service.chopper.dart';

@ChopperApi()
abstract class ArticleService extends ChopperService {
  static ArticleService create(ChopperClient client) =>
      _$ArticleService(client);

  @Get(
      path:
          "mostpopular/v2/mostviewed/all-sections/7.json?api-key=$articlesApiKey")
  Future<Response<ArticleResponse>> getArticles();
}
