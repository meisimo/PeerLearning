import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/ofertasTutoriasModel.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';
import 'package:peer_programing/src/widgets/stars_points.dart';

class Detalle extends StatefulWidget {
  final int detalle_id;
  final RaisedButton actionButton;

  Detalle (this.detalle_id, {this.actionButton}):super();

  @override
  State<StatefulWidget> createState() => DetalleState(this.detalle_id, this.actionButton);
}

class DetalleState extends State<Detalle> {
  static const int maxScore = 5;
  final int detalleId;
  final RaisedButton actionButton;
  var offers;
  
  DetalleState(this.detalleId, this.actionButton):super();

  Widget onInit() {
    return StreamBuilder(
      stream: Firestore.instance.collection('ofertas-tutorias').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
        return _buildDialog(context, snapshot.data.documents, this.detalleId);
      },
    );
  }

  _buildDialog(context, data, int id) {
    DocumentSnapshot docDetalles = data[0];
    // OfertasTutorias detalles = OfertasTutorias.fromSnapshot(docDetalles);
    Mentoring detalles = MentoringList.getById(id:id);

    return Container(
      width: 300,
      height: 500,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: <Widget>[
            _detailHeader(detalles),
            Container(
              height: 35,
              padding: EdgeInsets.all(5),
              child: CategoryList(dividerWidth: 10, categories: detalles.categories,),
            ),
            Divider(
              height: 2,
            ),
            _textContainer('Descripcion:', true),
            _textContainer(
                detalles.description, false),
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

  Widget _detailHeader(Mentoring detalles) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: LightColor.purple,
          ),
          title: Text(
            detalles.user.name,
            style: TextStyle(color: LightColor.purple),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StartsPoints( maxScore, detalles.points),
            Spacer(),
            this.actionButton,
          ],
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
