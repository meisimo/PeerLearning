import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/ofertasTutoriasModel.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detalle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetalleState();
  }
}

class DetalleState extends State<Detalle> {
  var offers;

  Widget onInit() {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
        return _buildDialog(context, snapshot.data.documents);
      },
    );
  }

  _buildDialog(context, data) {
    DocumentSnapshot docDetalles = data[0];
    OfertasTutorias detalles = OfertasTutorias.fromSnapshot(docDetalles);
    return Container(
      width: 300,
      height: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: <Widget>[
            _detailHeader(),
            _chipRow(),
            Divider(
              height: 2,
            ),
            _textContainer('Descripcion:', true),
            _textContainer(
                detalles.descripcion, false),
            Divider(
              height: 2,
            ),
            _textContainer('Tarifa:', true),
            _textContainer(detalles.precio.toString() + " \$/hora", false),
            Divider(
              height: 2,
            ),
            _textContainer('Lugar:', true),
            _textContainer(detalles.lugar, false),
            Divider(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: onInit(),
    );
  }

  Widget _detailHeader() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: LightColor.purple,
          ),
          title: Text(
            'Juan Erich',
            style: TextStyle(color: LightColor.purple),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.star,
              color: LightColor.orange,
            ),
            Icon(
              Icons.star,
              color: LightColor.orange,
            ),
            Icon(
              Icons.star,
              color: LightColor.orange,
            ),
            Icon(
              Icons.star,
              color: LightColor.orange,
            ),
            Icon(
              Icons.star_half,
              color: LightColor.orange,
            ),
            Spacer(),
            RaisedButton(
              child: Text('Registrarse'),
              color: LightColor.purple,
              onPressed: () => {Navigator.pop(context)},
            )
          ],
        ),
      ],
    );
  }

  Widget _chipRow() {
    return Row(
      children: <Widget>[
        Chip(
          label: Text(
            'Algebra',
            style: TextStyle(color: Colors.red[400]),
          ),
          backgroundColor: Colors.pink[50],
        ),
        Chip(
          label: Text(
            'Calculo',
            style: TextStyle(color: Colors.blue[400]),
          ),
          backgroundColor: Colors.lightBlue[50],
        ),
      ],
    );
  }

  Widget _textContainer(text, big) {
    if (big) {
      return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, color: LightColor.purple),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(color: LightColor.black),
          ),
        ),
      );
    }
  }
}
