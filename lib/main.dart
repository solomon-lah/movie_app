import 'package:briskit_assignment/movie_list/bloc/cloud_store_cubit/cubit/cloud_store_cubit.dart';
import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/bloc/movie-detail-bloc/cubit/movie_detail_cubit.dart';
import 'package:briskit_assignment/movie_list/providers/internet_connection_provider.dart';
import 'package:briskit_assignment/movie_list/screens/sign_up.dart';
import 'package:briskit_assignment/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) =>
                InternetConnectionCubit(InternetConnectionProvider()),
          ),
          BlocProvider(
            create: (context) => CloudStoreCubit(),
          ),
          BlocProvider(
              lazy: false,
              create: (context) => MovieDetailCubit(
                  BlocProvider.of<InternetConnectionCubit>(context))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Briskit Simple Top Movies App',
          theme: ThemeData(primarySwatch: Colors.grey),
          home: SignIn(),
          onGenerateRoute: Routes.SystemRoutes,
        ));
  }
}
