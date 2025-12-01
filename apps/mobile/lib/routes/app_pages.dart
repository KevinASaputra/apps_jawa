import '../pages/login.dart';
import '../routes/app_routes.dart';
import '../pages/warga/register/register_choice_page.dart';
import '../pages/warga/register/register_warga.dart';
import '../pages/warga/register/register_keluarga.dart';

class AppPages {
  static final routes = {
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.registerChoice: (context) => const RegisterChoicePage(),
    AppRoutes.registerWarga: (context) => const RegisterWargaPage(),
    AppRoutes.registerKeluarga: (context) => const RegisterKeluargaPage(),
  };
}
