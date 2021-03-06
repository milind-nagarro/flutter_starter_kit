import 'package:flutter_starter_kit/common/dataclass/result.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';

abstract class ArticleState {}

class Initial extends ArticleState {}

class Loading extends ArticleState {}

class Loaded extends ArticleState {
  final List<ArticleEntity> articles;

  Loaded(this.articles);
}

class LoadingFailed extends ArticleState {
  final FailureDetails failureDetails;

  LoadingFailed(this.failureDetails);
}

class LoadingError extends ArticleState {
  final ErrorDetails errorDetails;

  LoadingError(this.errorDetails);
}
