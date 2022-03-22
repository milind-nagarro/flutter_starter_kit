import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fab_nhl/app/app_config.dart';
import 'package:fab_nhl/app/app_constant.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/app/prefs/local_storage.dart';

import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit()
      : super(WelcomeState(message: welcomeScreenTitles[0], pageNumber: 0));
  void changePage(int page) =>
      emit(WelcomeState(message: welcomeScreenTitles[page], pageNumber: page));
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(AppLanguage lang) : super(LanguageState(lang));

  // change language button action
  void changeLanguage() {
    if (state.language == AppLanguage.english) {
      emit(LanguageState(AppLanguage.arabic));
      // store locale for next run
      LocalStorage.storeLangugePreference(AppLanguage.arabic.index);
    } else {
      emit(LanguageState(AppLanguage.english));
      // store locale for next run
      LocalStorage.storeLangugePreference(AppLanguage.english.index);
    }
    final appConfigHandler = locator<AppConfigHandler>();
    appConfigHandler.swapLocale();
  }
}
