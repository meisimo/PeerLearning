import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';
import 'package:peer_programing/src/widgets/stars_points.dart';

class Detalle extends StatefulWidget {
  final Mentoring _mentoring;
  final Widget actionButton;

  Detalle(this._mentoring, {this.actionButton}) : super();

  @override
  State<StatefulWidget> createState() =>
      DetalleState(this._mentoring, this.actionButton);
}

class DetalleState extends State<Detalle> {
  static const int maxScore = 5;
  // final int detalleId;
  final Mentoring _mentoring;
  final Widget actionButton;
  var offers;

  DetalleState(this._mentoring, this.actionButton) : super();

  _buildDialog(context) {
    return Container(
      width: 300,
      height: 500,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: <Widget>[
            _detailHeader(),
            Container(
              height: 35,
              padding: EdgeInsets.all(5),
              child: CategoryList(
                dividerWidth: 10,
                categories: this._mentoring.categories,
              ),
            ),
            Divider(
              height: 2,
            ),
            _textContainer('Descripcion:', true),
            _textContainer(this._mentoring.description, false),
            Divider(
              height: 2,
            ),
            _textContainer('Tarifa:', true),
            _textContainer(
                this._mentoring.precio.toString() + " \$/hora", false),
            Divider(
              height: 2,
            ),
            _textContainer('Lugar:', true),
            _textContainer(this._mentoring.lugar, false),
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
      child: _buildDialog(context),
    );
  }

  Widget _detailHeader() {
    return Column(
      children: <Widget>[
        ListTile(
        leading: CircleAvatar(
             backgroundColor: Colors.grey.shade300,
            backgroundImage: NetworkImage(this._mentoring.user.imgPath),
        ),
          title: Text(
            this._mentoring.user.name,
            style: TextStyle(color: LightColor.purple),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StartsPoints(maxScore, this._mentoring.points),
            Spacer(),
            this.actionButton != null ? this.actionButton : Text(''),
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
