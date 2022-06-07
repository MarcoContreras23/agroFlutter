import 'dart:convert';

import 'package:agro2/database/db.dart';
import 'package:agro2/model/product.dart';
import 'package:agro2/responsive/Adapt.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _CreateProduxtsState();
}

String email = "", password = "";

class _CreateProduxtsState extends State<LandingPage> {
  final formKey22 = GlobalKey<FormState>();
  final textFormFieldStyle = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 10, 140, 3), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  final textFormFieldStyleWrong = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 17, 90, 126), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  var spaceBetween = SizedBox(height: Adapt.hp(1));
  var spaceBetweenWidth = SizedBox(width: Adapt.wp(2));
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      primary: Color.fromARGB(255, 79, 130, 9),
      textStyle: TextStyle(
          fontSize: Adapt.px(40),
          fontWeight: FontWeight.bold,
          color: Colors.black));
  final ButtonStyle style2 = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      primary: Color.fromARGB(255, 34, 127, 151),
      textStyle: TextStyle(
          fontSize: Adapt.px(40),
          fontWeight: FontWeight.bold,
          color: Colors.black));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _body(context, style, spaceBetween, spaceBetweenWidth, style2),
        ));
  }

  Widget _body(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Container(
      child: Column(
        children: [
          _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2),
          Flexible(
            flex: 8,
            child: _bodyTwo(context, style, spaceBetweenWidth, style2,
                textFormFieldStyle, textFormFieldStyleWrong),
          ),
          _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2),
          spaceBetween,
        ],
      ),
    );
  }

  Widget _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(children: [
      Wrap(
        children: [
          Container(
            height: Adapt.hp(20),
            child: Column(
              children: [
                FittedBox(
                  child: Image(
                    height: Adapt.hp(13),
                    image: const AssetImage('assets/logo.png'),
                  ),
                ),
                spaceBetween,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Bienvenido a AgroMarket",
                    style: TextStyle(
                        fontSize: Adapt.px(40),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Adapt.wp(19),
          )
        ],
      ),
    ]);
  }

  Widget _bodyTwo(context, style, spaceBetweenWidth, style2, textFormFieldStyle,
      textFormFieldStyleWrong) {
    return Container(
      height: 550,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey22,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 80.0),
          child: Column(
            children: [
              correoInput(context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetweenWidth,
              passwordInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2) {
    final snackBar = SnackBar(
      content: Text('Se realizó el login correctamente'),
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      action: SnackBarAction(
        label: 'Ir',
        textColor: Color.fromARGB(255, 10, 10, 10),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/cart');
        },
      ),
    );
    return Column(
      children: [
        ElevatedButton(
          style: style,
          child: Text("INGRESAR",
              style: TextStyle(
                  fontSize: Adapt.px(22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onPressed: () {
            if (formKey22.currentState!.validate()) {
              setState(() {});
              _loguear();
              Scaffold.of(context).showSnackBar(snackBar);
            } else {
              print("no valido");
            }
          },
        ),
        ElevatedButton(
          style: style2,
          child: Text("REGISTRARSE",
              style: TextStyle(
                  fontSize: Adapt.px(22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onPressed: () =>
              {Navigator.pushReplacementNamed(context, '/registro')},
        ),
      ],
    );
  }

  Widget correoInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Adapt.px(30), horizontal: Adapt.px(15)),
        enabledBorder: textFormFieldStyle,
        disabledBorder: textFormFieldStyle,
        focusedBorder: textFormFieldStyle,
        errorBorder: textFormFieldStyleWrong,
        focusedErrorBorder: textFormFieldStyleWrong,
        label: const Text(
          "Correo",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        email = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  Widget passwordInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Adapt.px(30), horizontal: Adapt.px(15)),
        enabledBorder: textFormFieldStyle,
        disabledBorder: textFormFieldStyle,
        focusedBorder: textFormFieldStyle,
        errorBorder: textFormFieldStyleWrong,
        focusedErrorBorder: textFormFieldStyleWrong,
        label: const Text(
          "Contraseña",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        password = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  void _loguear() {
    if (formKey22.currentState!.validate()) {
      final data = {
        'email': email,
        'password': password,
      };
      setState(() {});
      _queryData(data);
    } else {
      print("no valido");
    }
  }

  void _queryData(data) {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataCategorie = Product.fromJson(user);
    DB.instance.insertDataProduct(dataCategorie);
  }
}
