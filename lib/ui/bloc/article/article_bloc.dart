import 'package:fab_nhl/common/dataclass/status.dart';
import 'package:fab_nhl/domain/repository/iarticle_repository.dart';
import 'package:fab_nhl/ui/bloc/article/article_event.dart';
import 'package:fab_nhl/ui/bloc/article/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final IArticleRepository _articleRepository;

  ArticleBloc(this._articleRepository) : super(Initial()) {
    on<ArticleLoadEvent>(_onArticleLoadEvent);
  }

  _onArticleLoadEvent(
      ArticleLoadEvent event, Emitter<ArticleState> emit) async {
    emit(Loading());

    final response = await _articleRepository.getArticles();
    switch (response.status) {
      case Status.success:
        emit(Loaded(response.data!));
        break;
      case Status.failure:
        emit(LoadingFailed(response.failureDetails!));
        break;
      case Status.error:
        emit(LoadingError(response.errorDetails!));
        break;
    }
  }
}
