// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../crosscutting/crash/app_crashlytics.dart' as _i5;
import '../../crosscutting/crash/iapp_crashlytics.dart' as _i4;
import '../../data/remote/service/article_service.dart' as _i8;
import '../../data/repository/article_repository.dart' as _i7;
import '../../domain/repository/iarticle_repository.dart' as _i6;
import '../../ui/bloc/article/article_bloc.dart' as _i11;
import '../../ui/router/app_router.dart' as _i10;
import '../../ui/router/navigation_service.dart' as _i9;
import '../app_config.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AppConfigHandler>(() => _i3.AppConfigHandler());
  gh.factory<_i4.IAppCrashlytics>(() => _i5.AppCrashlytics());
  gh.factory<_i6.IArticleRepository>(
      () => _i7.ArticleRepository(get<_i8.ArticleService>()));
  gh.lazySingleton<_i9.NavigationService<dynamic, dynamic>>(
      () => _i9.NavigationService<dynamic, dynamic>());
  gh.factory<_i10.AppRouter>(
      () => _i10.AppRouter(get<_i9.NavigationService<dynamic, dynamic>>()));
  gh.factory<_i11.ArticleBloc>(
      () => _i11.ArticleBloc(get<_i6.IArticleRepository>()));
  return get;
}
