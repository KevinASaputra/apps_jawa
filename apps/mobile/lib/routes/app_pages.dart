import '../features/login.dart';
import '../routes/app_routes.dart';
import '../features/register/pages/warga/register_choice_page.dart';
import '../features/register/pages/warga/register_warga.dart';
import '../features/register/pages/warga/register_keluarga.dart';
import '../features/dashboard/admin/dashboard.dart';
import '../features/dashboard/warga/dashboard.dart';

class AppPages {
  static final routes = {
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.registerChoice: (context) => const RegisterChoicePage(),
    AppRoutes.registerWarga: (context) => const RegisterWargaPage(),
    AppRoutes.registerKeluarga: (context) => const RegisterKeluargaPage(),
    AppRoutes.dashboardAdmin: (context) => const AdminDashboard(),
    AppRoutes.dashboardWarga: (context) => const WargaDashboard(),

  };
}
