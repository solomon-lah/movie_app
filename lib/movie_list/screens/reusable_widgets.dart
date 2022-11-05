import 'package:flutter/material.dart';

Container ReusableTextFormField(
    {required String hintext,
    bool obsucreText = false,
    required TextEditingController textEditingController}) {
  return Container(
    margin: EdgeInsets.all(20.0),
    child: TextFormField(
      obscureText: obsucreText,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintext,
      ),
    ),
  );
}

IconButton NavigationBarIconButton(
    {required Function onpressed, required IconData iconData}) {
  return IconButton(
      onPressed: () {
        onpressed();
      },
      icon: Icon(
        color: Colors.black,
        iconData,
        size: 30,
      ));
}
