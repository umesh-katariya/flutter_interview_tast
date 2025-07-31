// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق قائمة المستخدمين';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get language => 'اللغة';

  @override
  String get lightTheme => 'الوضع الفاتح';

  @override
  String get darkTheme => 'الوضع الداكن';

  @override
  String get searchUser => 'ابحث عن مستخدم';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get users => 'المستخدمين';

  @override
  String get details => 'تفاصيل';

  @override
  String get authenticationFailedResponseMsg => 'فشل المصادقة';

  @override
  String get noDataFound => 'لم يتم العثور على بيانات';

  @override
  String get userDetails => 'تفاصيل المستخدم';
}
