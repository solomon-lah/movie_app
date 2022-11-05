//For Signing up

import 'package:briskit_assignment/movie_list/bloc/cloud_store_cubit/cubit/cloud_store_cubit.dart';
import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/constants.dart';
import 'package:briskit_assignment/movie_list/screens/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Key _form = GlobalKey();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/sign_in'),
          child: Icon(Icons.login),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white10.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                      padding: EdgeInsets.all(15.0),
                      height: 150.0,
                      width: 150.0,
                      child: Image.asset(
                        AssetImageProvider.LOGO_IMAGE,
                        fit: BoxFit.contain,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.2),
                          shape: BoxShape.circle),
                    )),
                    SizedBox(
                      height: 50.0,
                    ),
                    Form(
                      key: _form,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        child: Column(
                          children: <Widget>[
                            ReusableTextFormField(
                                hintext: 'USERNAME',
                                textEditingController: _username),
                            ReusableTextFormField(
                                hintext: 'PASSWORD',
                                textEditingController: _password,
                                obsucreText: true)
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Colors.grey.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            child:
                                BlocBuilder<CloudStoreCubit, CloudStoreState>(
                              builder: (context, state) {
                                return BlocConsumer<CloudStoreCubit,
                                    CloudStoreState>(
                                  listener: (context, state) {
                                    if (state is LoginState) {
                                      Navigator.pushReplacementNamed(
                                          context, '/movie_list');
                                    } else if (state is FailToLoginState) {
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext buildContext) =>
                                                  AlertDialog(
                                                    actions: [
                                                      OutlinedButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text('Close'))
                                                    ],
                                                    content: Text(
                                                        'This Username Exists'),
                                                  ));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is RestingState ||
                                        state is FailToLoginState) {
                                      return ListTile(
                                        iconColor: Colors.white,
                                        title: Text(
                                          'SIGN UP',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailing:
                                            Icon(Icons.navigate_next_sharp),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            onPressed: () {
                              if (BlocProvider.of<InternetConnectionCubit>(
                                      context)
                                  .state is ActiveInternetConnectionState) {
                                BlocProvider.of<CloudStoreCubit>(context)
                                    .register(
                                        username: _username.text,
                                        password: _password.text);
                              }
                            },
                          );
                        })),
                    /*Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('SIGN UP'),
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Colors.grey.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    )*/
                  ],
                ))),
      ),
    );
  }
}
