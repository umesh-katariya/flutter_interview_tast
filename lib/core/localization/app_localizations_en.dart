// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'User List';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get logout => 'Logout';

  @override
  String get language => 'Language';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get searchUser => 'Search user';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get retry => 'Retry';

  @override
  String get users => 'Users';

  @override
  String get details => 'Details';

  @override
  String get authenticationFailedResponseMsg => 'Authentication Failed';

  @override
  String get noDataFound => 'No Data Found';

  @override
  String get userDetails => 'User Details';
}
