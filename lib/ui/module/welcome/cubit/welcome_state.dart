import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/app/resources/app_constants.dart';

class WelcomeState extends Equatable {
  const WelcomeState({required this.pageNumber, required this.message});
  final String message;
  final int pageNumber;

  @override
  List<Object?> get props => [pageNumber];
}

class LanguageState extends Equatable {
  LanguageState(this.language) {
    nextLanguageTitle =
        language == AppLanguage.english ? arabic_label : english_label;
  }
  final AppLanguage language;
  late String nextLanguageTitle;

  @override
  List<Object?> get props => [language];
}
