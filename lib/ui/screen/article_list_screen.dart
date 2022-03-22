import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/app/resources/dimen.dart' as dimen;
import 'package:fab_nhl/crosscutting/analytics/iapp_analytics.dart';
import 'package:fab_nhl/domain/entity/article_entity.dart';
import 'package:fab_nhl/ui/bloc/article/article_bloc.dart';
import 'package:fab_nhl/ui/bloc/article/article_event.dart';
import 'package:fab_nhl/ui/bloc/article/article_state.dart';
import 'package:fab_nhl/ui/router/app_router.dart';
import 'package:fab_nhl/ui/screen/common_widget/circle_image.dart';
import 'package:fab_nhl/ui/screen/common_widget/progress_bar.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).articles)),
        body: BlocProvider(
          create: (context) => locator<ArticleBloc>(),
          child: const _ArticleListView(),
        ),
      );
}

class _ArticleListView extends StatelessWidget {
  const _ArticleListView({Key? key}) : super(key: key);

  void _loadArticles(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context).add(ArticleLoadEvent());

  @override
  Widget build(BuildContext context) {
    locator<IAppAnalytics>().logScreenView("Article_List_Screen");
    _loadArticles(context);
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is Loaded) {
          return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, state.articles[index]));
        } else if (state is LoadingError) {
          return Center(child: Text(state.errorDetails.exception.toString()));
        } else if (state is LoadingFailed) {
          return Center(
              child: Text(state.failureDetails.error?.toString() ?? ''));
        } else {
          return const Center(child: ProgressBar());
        }
      },
    );
  }

  Widget _buildListItem(BuildContext context, ArticleEntity entity) {
    return ListTile(
      isThreeLine: true,
      subtitle: Text(entity.date, textDirection: TextDirection.rtl),
      contentPadding: const EdgeInsets.all(dimen.margin10),
      title: Text(entity.title, style: const TextStyle(fontSize: dimen.font18)),
      leading: CircleImage(url: entity.imageUrl, radius: dimen.margin40),
      onTap: () => locator<AppRouter>().showArticleDetailScreen(entity),
    );
  }
}
