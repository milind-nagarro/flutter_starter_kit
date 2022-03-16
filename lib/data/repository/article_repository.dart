import 'package:flutter_starter_kit/common/dataclass/result.dart';
import 'package:flutter_starter_kit/data/remote/response/article_response.dart';
import 'package:flutter_starter_kit/data/remote/service/article_service.dart';
import 'package:flutter_starter_kit/data/repository/base_repository.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';
import 'package:flutter_starter_kit/domain/repository/iarticle_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IArticleRepository)
class ArticleRepository extends BaseRepository implements IArticleRepository {
  final ArticleService _articleService;

  ArticleRepository(this._articleService);

  @override
  Future<Result<List<ArticleEntity>?>> getArticles() {
    return makeNetworkCall(
        networkCall: () => _articleService.getArticles(),
        map: (ArticleResponse? response) =>
            response?.articles.map((e) => e.toEntity()).toList());
  }
}
