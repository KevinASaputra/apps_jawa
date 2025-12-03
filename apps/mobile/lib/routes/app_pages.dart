import '../pages/login.dart';
import '../routes/app_routes.dart';
import '../pages/features/register/register_choice_page.dart';
import '../pages/features/register/register_warga.dart';
import '../pages/features/register/register_keluarga.dart';

class AppPages {
  static final routes = {
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.registerChoice: (context) => const RegisterChoicePage(),
    AppRoutes.registerWarga: (context) => const RegisterWargaPage(),
    AppRoutes.registerKeluarga: (context) => const RegisterKeluargaPage(),
  };
}
