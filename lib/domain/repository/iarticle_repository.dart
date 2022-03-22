import 'package:fab_nhl/common/dataclass/result.dart';
import 'package:fab_nhl/domain/entity/article_entity.dart';

abstract class IArticleRepository {
  Future<Result<List<ArticleEntity>?>> getArticles();
}
