const welcomeScreenTitles = <String>[
  'welcome_msg_1',
  'welcome_msg_2',
  'welcome_msg_3'
];
enum AppLanguage {
  english,
  arabic,
}
const localeEn = 'en';
const localeAr = 'ar';
const uaeCode = '+971 ';
const arabic_label = 'ةيبرعلا';
const english_label = 'English';
const key_user_info = 'user_info';
const key_language_preference = 'language_preference';

enum ValidationState { notChecked, valid, invalid }
enum LoginStates { notChecked, checking, authenticated, unauthenticated }
