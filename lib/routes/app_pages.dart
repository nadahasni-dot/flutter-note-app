import 'package:get/get.dart';

import '../screens/create_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/edit_screen.dart';
import '../screens/home_screen.dart';
import 'route_names.dart';

class AppPages {
  static final appPages = [
    GetPage(
      name: RouteNames.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RouteNames.createScreen,
      page: () => const CreateScreen(),
    ),
    GetPage(
      name: RouteNames.detailScreen,
      page: () => const DetailScreen(),
    ),
    GetPage(
      name: RouteNames.editScreen,
      page: () => const EditScreen(),
    ),
  ];
}
