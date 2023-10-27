import 'package:cova_admin_dashboard/pages/cart/carts.dart';
import 'package:cova_admin_dashboard/pages/supports/supports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../inital.dart';
import '../pages/404/error.dart';
import '../pages/authentication/authentication.dart';
import '../pages/user_detail/user_detail.dart';
import '../pages/users/users.dart';
import '../pages/overview/overview.dart';

class RouteHelper {
  static const initial = "/";
  static const overview = "/overview";
  static const users = "/users";
  static const userDetail = "/user-detail";
  static const supports = "/supports";
  static const cart = "/cart";
  static const profile = "/profile";
  static const notification = "/notification";
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String unknown = '/unknown';

  //Services
  static const String cloudService = '/cloud-service';
  static const String zenithlink = '/zenithlink';
  static const String ftRendering = '/ftRendering';

  static String getInitialRoute() => initial;
  static String getOverViewRoute(String route) => route + overview;
  static String getUsersRoute(String route) => '$route$users';
  static String getUserDetailRoute() => '$userDetail?uid=uc9ysWq3vdPBInqnk9164BGmFUH3';
  static String getSupportsRoute(String route) => '$route$supports';
  static String getCartRoute(String route, String uid) => '$route$cart?uid=$uid';
  static String getNotificationRoute() => notification;
  static String getSignInRoute() => signIn;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return  const InitialPage();
        }),
    //Cloud Service
    GetPage(
        name: cloudService + overview,
        page: () {
          return  const OverviewPage(serviceLink: AppConstants.cloudServiceCollection , serviceName: AppConstants.cloudService);
        }),
    GetPage(name: cloudService + users, page: () => const UsersPage(serviceLink: AppConstants.cloudServiceCollection, serviceName: AppConstants.cloudService)),
    GetPage(name: userDetail, page: () => UserDetailPage(uid: Get.parameters['uid'], serviceLink: AppConstants.cloudServiceCollection, serviceName: AppConstants.cloudService)),

    GetPage(name: cloudService + supports, page: () => const SupportsPages(serviceLink: AppConstants.cloudServiceCollection, serviceName: AppConstants.cloudService)),
    GetPage(name: cloudService + users + cart , page: () => CartsPage(uid: Get.parameters['uid']!, serviceLink: AppConstants.cloudServiceCollection, serviceName: AppConstants.cloudService)),

    //Zenith Link
    GetPage(
        name: zenithlink + overview,
        page: () {
          return const OverviewPage(serviceLink: AppConstants.zenithlinkCollection,serviceName: AppConstants.zenithLink);
        }),
    GetPage(name: zenithlink + users, page: () => const UsersPage(serviceLink: AppConstants.zenithlinkCollection ,serviceName: AppConstants.zenithLink )),

    GetPage(name: zenithlink + supports, page: () => const SupportsPages(serviceLink: AppConstants.zenithlinkCollection,serviceName: AppConstants.zenithLink)),
    GetPage(name: zenithlink + users + cart , page: () => CartsPage(uid: Get.parameters['uid']!, serviceLink: AppConstants.zenithlinkCollection,serviceName: AppConstants.zenithLink )),

    //FTRendering
    GetPage(
        name: ftRendering + overview,
        page: () {
          return const OverviewPage(serviceLink: AppConstants.ftRenderingCollection,serviceName: AppConstants.ftRendering);
        }),
    GetPage(name: ftRendering + users, page: () => const UsersPage(serviceLink: AppConstants.ftRenderingCollection ,serviceName: AppConstants.ftRendering )),

    GetPage(name: signIn, page: () => const AuthenticationPage()),
    GetPage(name: unknown, page: () => const PageNotFound())
  ];

  static GetPage getUnknownPage() =>
      GetPage(name: unknown, page: () => const PageNotFound());
}

class MenuItem {
  final String? name;
  final String? route;
  final IconData? icon;

  MenuItem({this.name, this.route, this.icon});
}

class MainMenuItem extends MenuItem {
  final List<MenuItem>? sideMenu;
  final String? image;

  MainMenuItem({super.name, super.route, this.sideMenu, this.image});
}

List<MainMenuItem> sideMenuItemRoutes = [
  MainMenuItem(
    name: AppConstants.cloudService,
    sideMenu: [
      MenuItem(
          name: AppConstants.overview,
          route: RouteHelper.getOverViewRoute(RouteHelper.cloudService),
          icon: Icons.trending_up),
      MenuItem(
          name: AppConstants.users,
          route: RouteHelper.getUsersRoute(RouteHelper.cloudService),
          icon: Icons.groups),
      MenuItem(
          name: AppConstants.supports,
          route: RouteHelper.getSupportsRoute(RouteHelper.cloudService),
          icon: Icons.support),
    ],
  ),
  MainMenuItem(
    name: AppConstants.zenithLink,
    sideMenu: [
      MenuItem(
          name: AppConstants.overview,
          route: RouteHelper.getOverViewRoute(RouteHelper.zenithlink),
          icon: Icons.trending_up),
      MenuItem(
          name: AppConstants.users,
          route: RouteHelper.getUsersRoute(RouteHelper.zenithlink),
          icon: Icons.groups),
      // MenuItem(
      //     name: AppConstants.supports,
      //     route: RouteHelper.getSupportsRoute(RouteHelper.zenithlink),
      //     icon: Icons.support),
    ],
  ),
  MainMenuItem(
    name: AppConstants.ftRendering,
    sideMenu: [
      MenuItem(
          name: AppConstants.overview,
          route: RouteHelper.getOverViewRoute(RouteHelper.ftRendering),
          icon: Icons.trending_up),
      MenuItem(
          name: AppConstants.users,
          route: RouteHelper.getUsersRoute(RouteHelper.ftRendering),
          icon: Icons.groups),
      // MenuItem(
      //     name: AppConstants.supports,
      //     route: RouteHelper.getSupportsRoute(RouteHelper.zenithlink),
      //     icon: Icons.support),
    ],
  ),

];

MenuItem logout = MenuItem(
    name: AppConstants.logOut,
    route: RouteHelper.getSignInRoute(),
    icon: Icons.logout);
