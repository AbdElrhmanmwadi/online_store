import 'package:emart_app/controller/savelogincontrolle.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class Auth_Middleweare extends GetMiddleware {
  // @override
  // TODO: implement priority
  // int? get priority => 2;
  @override
  redirect(String? route) {
    if (SaveController().getstorge() == '1') {
      return RouteSettings(name: '/home');
    } else {
      return RouteSettings(name: '/login');
    }
  }
}
