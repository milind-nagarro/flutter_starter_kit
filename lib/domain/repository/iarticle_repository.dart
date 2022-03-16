import 'package:flutter_starter_kit/common/dataclass/result.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';

abstract class IArticleRepository {
  Future<Result<List<ArticleEntity>?>> getArticles();
}
