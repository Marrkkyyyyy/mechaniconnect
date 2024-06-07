import 'package:get/get.dart';
import 'package:mechaniconnect/core/constant/routes.dart';
import 'package:mechaniconnect/view/screen/admin/admin_dashboard.dart';
import 'package:mechaniconnect/view/screen/admin/category.dart';
import 'package:mechaniconnect/view/screen/admin/history.dart';
import 'package:mechaniconnect/view/screen/admin/history_details.dart';
import 'package:mechaniconnect/view/screen/admin/mechanic.dart';
import 'package:mechaniconnect/view/screen/admin/request.dart';
import 'package:mechaniconnect/view/screen/admin/request_details.dart';
import 'package:mechaniconnect/view/screen/admin/service.dart';
import 'package:mechaniconnect/view/screen/auth/login.dart';
import 'package:mechaniconnect/view/screen/auth/register.dart';
import 'package:mechaniconnect/view/screen/customer/customer_dashboard.dart';
import 'package:mechaniconnect/view/screen/customer/customer_history.dart';
import 'package:mechaniconnect/view/screen/customer/customer_history_details_controller.dart';
import 'package:mechaniconnect/view/screen/customer/customer_request_details.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: "/", page: () => const TestView()),
  GetPage(name: "/", page: () => const LoginPage()),
  // GetPage(name: "/", page: () => const StudentDashboard()),
  // GetPage(name: AppRoute.home, page: () => HomeScreen()),

  // ********************** Authentication
  // GetPage(
  //     name: AppRoute.loginPage,
  //     page: () => const LoginPage(),
  //     transition: Transition.rightToLeft,
  //     transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.registerPage,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  // ********************** Customer
  GetPage(
      name: AppRoute.customerDashboard,
      page: () => const CustomerDashboard(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.customerRequestDetails,
      page: () => const CustomerRequestDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  // ********************** Admin

  GetPage(
      name: AppRoute.adminDashboard,
      page: () => const AdminDashboard(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.categoryPage,
      page: () => const CategoryPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.servicePage,
      page: () => const ServicePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  GetPage(
      name: AppRoute.mechanicPage,
      page: () => const MechanicPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.requestPage,
      page: () => const RequestPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.requestDetails,
      page: () => const RequestDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.historyPage,
      page: () => const HistoryPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.historyDetails,
      page: () => const HistoryDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.customerHistoryPage,
      page: () => const CustomerHistoryPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
      name: AppRoute.customerHistoryDetails,
      page: () => const CustomerHistoryDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
];
