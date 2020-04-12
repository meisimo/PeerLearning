import 'package:flutter/material.dart';

class LDropDown extends StatefulWidget {
  @override
  _LDropDownState createState() => _LDropDownState();
}

class _LDropDownState extends State<LDropDown> {
  String dropdownValue = 'Seleccionar tutoria ';
  List<String> dropdownItems = <String>[
    'Seleccionar tutoria ',
    'Ingles',
    'Calculo',
    'Logica computacional',
    "Programacion",
    "Fisica",
    "Psicologia",

  ];

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 25,
          elevation: 8,
          style: TextStyle(color: Colors.black, fontSize: 20),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/*
**********
**********
**********
**********
*** END***
**********
**********
**********
**********
 */