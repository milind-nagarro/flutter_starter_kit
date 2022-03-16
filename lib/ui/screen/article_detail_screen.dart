import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_starter_kit/app/resources/assets.dart' as assets;
import 'package:flutter_starter_kit/app/resources/colors.dart' as colors;
import 'package:flutter_starter_kit/app/resources/dimen.dart' as dimens;
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleEntity _articleEntity;

  const ArticleDetailScreen(this._articleEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).articleDetail)),
      body: _buildArticleDetailWidget(context));

  Widget _buildArticleDetailWidget(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FadeInImage(
            image: NetworkImage(_articleEntity.imageUrl),
            placeholder: const AssetImage(assets.placeholder),
            height: dimens.size300,
            fit: BoxFit.cover),
        Padding(
            padding: const EdgeInsets.all(dimens.margin20),
            child: Text(_articleEntity.title,
                style: const TextStyle(
                    fontSize: dimens.font22, color: colors.primaryColor))),
        Padding(
            padding: const EdgeInsets.fromLTRB(dimens.margin20, dimens.margin0,
                dimens.margin20, dimens.margin20),
            child: Text(_articleEntity.description,
                style: const TextStyle(fontSize: dimens.font20))),
        Padding(
            padding: const EdgeInsets.only(right: dimens.margin20),
            child: Align(
                child: Text(
                    "${AppLocalizations.of(context).publishedOn} ${_articleEntity.date}"),
                alignment: Alignment.centerRight))
      ],
    ));
  }
}
