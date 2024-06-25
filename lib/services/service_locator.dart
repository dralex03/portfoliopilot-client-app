import 'package:androidproject/controller/dashboard_controller.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // state management layer
  getIt.registerLazySingleton<LoginScreenController>(() => LoginScreenController());
  getIt.registerLazySingleton<DashboardController>(() => DashboardController());

  // service layer
}