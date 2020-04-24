import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';

class LDropDown extends StatefulWidget {
  @override
  _LDropDownState createState() => _LDropDownState();
}

class _LDropDownState extends State<LDropDown> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
               child: MultiSelectFormField(
                  autovalidate: true,
                  titleText: 'Turorias',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Porfavor selecciona una o mas de una';
                    }
                  },
                  dataSource: [
                    {
                      "display": "Ingles",
                      "value": "Ingles",
                    },
                    {
                      "display": "Calculo",
                      "value": "Calculo",
                    },
                    {
                      "display": "Logica computacional",
                      "value": "Logica computacional",
                    },
                    {
                      "display": "Programacion",
                      "value": "Programacion",
                    },
                    {
                      "display": "Fisica",
                      "value": "Fisica",
                    },
                    {
                      "display": "Estadistica",
                      "value": "Estadistica",
                    },

                     {
                      "display": "Literatura",
                      "value": "Literatura",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  required: true,
                  hintText: 'Selecciona una o mas de una ',
                  value: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(1),                
              //   child: RaisedButton(
              //     child: Text('Save'),
              //     onPressed: _saveForm,
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.all(1),
              //   child: Text(_myActivitiesResult),
              // )
            ],
          ),
        ),
      );
  }
}





//   String dropdownValue = 'Seleccionar tutoria ';
//   List<String> dropdownItems = <String>[
//     'Seleccionar tutoria ',
//     'Ingles',
//     'Calculo',
//     'Logica computacional',
//     "Programacion",
//     "Fisica",
//     "Psicologia",

//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       child: Center(
//         child: DropdownButton<String>(
//           value: dropdownValue,
//           icon: Icon(Icons.arrow_drop_down),
//           iconSize: 25,
//           elevation: 8,
//           style: TextStyle(color: Colors.black, fontSize: 20),
//           onChanged: (String newValue) {
//             setState(() {
//               dropdownValue = newValue;
//             });
//           },
//           items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }


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