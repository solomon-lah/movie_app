import 'package:briskit_assignment/movie_list/models.dart';
import 'package:briskit_assignment/movie_list/screens/movie_detail.dart';
import 'package:briskit_assignment/movie_list/screens/movie_list.dart';
import 'package:briskit_assignment/movie_list/screens/register.dart';
import 'package:briskit_assignment/movie_list/screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Manages system Routes
class Routes {
  static Route<dynamic> SystemRoutes(RouteSettings routeSettings) {
    Route Goto(Widget w, RouteSettings routeSettings) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return MaterialPageRoute(builder: (builder) => w);
      } else {
        return CupertinoPageRoute(builder: (builder) => w);
      }
    }

    switch (routeSettings.name) {
      case '/sign_up':
        return Goto(SignUp(), routeSettings);
      case '/sign_in':
        return Goto(SignIn(), routeSettings);
      case '/movie_list':
        return Goto(MovieList(), routeSettings);
      case '/movie_detail':
        MovieDetailParams movieDetailParams =
            routeSettings.arguments as MovieDetailParams;
        return Goto(MovieDetailScreen(movieDetailParams: movieDetailParams),
            routeSettings);

      default:
        return Goto(SignIn(), routeSettings);
    }
  }
}
