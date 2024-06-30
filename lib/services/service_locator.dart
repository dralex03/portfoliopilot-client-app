import 'package:androidproject/controller/add_controller.dart';
import 'package:androidproject/controller/dashboard_controller.dart';
import 'package:androidproject/controller/profile_controller.dart';
import 'package:get_it/get_it.dart';

import 'package:androidproject/controller/login_controller.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // state management layer
  getIt.registerLazySingleton<LoginScreenController>(() => LoginScreenController());
  getIt.registerLazySingleton<DashboardController>(() => DashboardController());
  getIt.registerLazySingleton<AddController>(() => AddController());
  getIt.registerLazySingleton<ProfileController>(() => ProfileController());
}