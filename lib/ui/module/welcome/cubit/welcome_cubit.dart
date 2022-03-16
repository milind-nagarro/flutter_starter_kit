import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/app_constant.dart';

import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit()
      : super(WelcomeState(message: welcomeScreenTitles[0], pageNumber: 0));
  void changePage(int page) =>
      emit(WelcomeState(message: welcomeScreenTitles[page], pageNumber: page));
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(AppLanguage english)
      : super(LanguageState(AppLanguage.english));
  void changeLanguage() {
    if (state.language == AppLanguage.english) {
      emit(LanguageState(AppLanguage.arabic));
    } else {
      emit(LanguageState(AppLanguage.english));
    }
  }
}
