import 'package:get/get.dart';
import 'package:pock_gym/chat_room_page.dart';
import 'package:pock_gym/healthGraph/steps_graph.dart';
import 'package:pock_gym/ui/intro/splash/splash_page.dart';

import '../../healthGraph/weight_graph.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    // GetPage(
    //   name: '/',
    //   page: () => WeightGraphPage(
    //     startDate: DateTime(2022, 9, 1),
    //     endDate: DateTime(2023, 2, 3),
    //   ),
    // ),
    GetPage(name: '/', page: () => SplashPage()),
    // GetPage(name: '/login', page: () => LoginPage()),
    // GetPage(name: '/main', page: () => MainRootPage()),
  ];
}
