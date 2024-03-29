// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:agro2/database/db.dart';
import 'package:agro2/model/category.dart';
import 'package:agro2/responsive/Adapt.dart';
import 'package:flutter/material.dart';

class CreateCategorie extends StatefulWidget {
  const CreateCategorie({Key? key}) : super(key: key);

  @override
  State<CreateCategorie> createState() => _CreateCategorieState();
}

String name = "", description = "";

class _CreateCategorieState extends State<CreateCategorie> {
  
  ///Estilos para los botones y los campos input
  final formKey22 = GlobalKey<FormState>();
  final textFormFieldStyle = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 2, 119, 189), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  final textFormFieldStyleWrong = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  var spaceBetween = SizedBox(height: Adapt.hp(1));
  var spaceBetweenWidth = SizedBox(width: Adapt.wp(2));
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(10)),
      primary: Colors.lightBlue[800],
      textStyle: TextStyle(
          fontSize: Adapt.px(30),
          fontWeight: FontWeight.bold,
          color: Colors.black));
  final ButtonStyle style2 = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(10)),
      primary: const Color.fromARGB(255, 254, 37, 37),
      textStyle: TextStyle(
          fontSize: Adapt.px(30),
          fontWeight: FontWeight.bold,
          color: Colors.black));

  ///Widget principal de la clase que contiene todos los elementos de la vista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _body(context, style, spaceBetween, spaceBetweenWidth, style2),
        ));
  }

  /// Widget que contiene las tres partes de la vista, NavBar, Formulario y Botones
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

  /// Widget que contiene el NavBar
  Widget _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(children: [
      Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(60)),
            child: bottonBack(),
          ),
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Crear nueva categoria",
                      style: TextStyle(
                          fontSize: Adapt.px(40),
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
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

  /// Widget que contiene el formulario
  Widget _bodyTwo(context, style, spaceBetweenWidth, style2, textFormFieldStyle,
      textFormFieldStyleWrong) {
    return Container(
      height: 550,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey22,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              nombreInput(context, textFormFieldStyle, textFormFieldStyleWrong),
              descripcionInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget que contiene los botones
  Widget _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: Adapt.wp(35),
              child: ElevatedButton(
                style: style,
                child: Text("CREAR",
                    style: TextStyle(
                        fontSize: Adapt.px(22),
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
                onPressed: () {
                  if (formKey22.currentState!.validate()) {
                    setState(() {});
                    _register();
                  } else {
                    print("no valido");
                  }
                },
              ),
            ),
            SizedBox(width: Adapt.wp(5)),
            SizedBox(
              width: Adapt.wp(35),
              child: ElevatedButton(
                style: style2,
                child: Text("CANCELAR",
                    style: TextStyle(
                        fontSize: Adapt.px(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Widget que tiene el boton de regreso a la pantalla anterior
  Widget bottonBack() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(15), vertical: Adapt.px(22)),
        primary: const Color.fromARGB(255, 2, 119, 189),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/');
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: Adapt.px(35),
      ),
    );
  }

  /// Widget que contiene el campo del formulario del nombre
  Widget nombreInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
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
          "Nombre",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        name = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  /// Widget que contiene el campo del formulario de la descripcion
  Widget descripcionInput(
      context, textFormFieldStyle, textFormFieldStyleWrong) {
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
          "Descripción",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        description = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  /// funcion que se ejecuta cuando se presiona el boton de crear
  void _register() {
    if (formKey22.currentState!.validate()) {
      final data = {
        'name': name,
        'description': description,
      };
      setState(() {});
      _queryData(data);
    } else {
      print("no valido");
    }
  }

  /// Funcion encargada de crear el producto en base de datos
  void _queryData(data) {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataCategorie = Categoria.fromJson(user);
    DB.instance.insertData(dataCategorie);
  }
}
