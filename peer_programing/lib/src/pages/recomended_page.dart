import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/utils/generate_random_gravatar.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/tarjetas/mini_card.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

class RecomendedPage extends StatelessWidget {
  RecomendedPage({Key key}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return MainLayout(
      title: "Favoritos",
      body: RecomendedMentorByCategoryList(),
      defaultVerticalScroll: false,
    );
  }
}

class RecomendedMentorByCategoryList extends StatefulWidget {
  @override
  _RecomendedMentorByCategoryList createState() =>
      _RecomendedMentorByCategoryList();
}

class _RecomendedMentorByCategoryList
    extends State<RecomendedMentorByCategoryList> {
  List<UserModel> _recomendedUsers;
  bool _checkConnection = true, _connected = false;

  void _handleConnectivity({Function onSuccess, Function onError}) =>
      handleConnectivity(
          onSuccess: onSuccess,
          onError: onError,
          onResponse: () => this._checkConnection = false);

  Widget _recomendedList() => ListView(
        children: <Widget>[
          _categoryRow(
              "Tutores recomendados", LightColor.orange, LightColor.orange),
          _featuredRowA(),
          SizedBox(height: 0),
        ],
      );

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _featuredRowA() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _recomendedUsers.map<Widget>((user) {
              final int nCalificaciones = user.califications == null ? 0 : user.califications.length;
              return nCalificaciones != 0
                  ? MiniCard(
                      tutor: user,
                      primary: LightColor.rand(),
                      backWidget: Decorator.generateDecoration(),
                      chipColor: LightColor.rand(),
                      chipText1: user.name,
                      chipText2: nCalificaciones.toString() + ( nCalificaciones == 1 ? " Calificación" : " Calificaciones"),
                      chipText3: truncateDouble(user.points, 1).toString() + " puntos",
                      isPrimaryCard: true,
                      imgPath: user.imgPath != null
                          ? user.imgPath
                          : generateRandomGravatarUrl())
                  : Text('');
            }).toList()),
      ),
    );
  }

  Widget _showPage() => StreamBuilder(
      stream: UserModel.recomendenMentorsSnapshot(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        if (_recomendedUsers == null) {
          _recomendedUsers = UserModel.listFromSnapshot(snapshot.data.documents);
        }
        return _recomendedUsers == null ? Loading() : _recomendedList();
      });

  Widget _showNotConnectedPage() =>
    Padding(
        padding: EdgeInsets.all(100),
        child: Text(
          "No hay internet :(",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
    );

  void _showNotConnectedDialog(context) => showDialog(
      context: context,
      child: NotConnectedCard(tryToReconnect: () {
        Navigator.of(context).pop();
        setState(() {
          this._checkConnection = true;
        });
      }));

  void _initCheckConnection(context) => _handleConnectivity(
      onError: () {
        _showNotConnectedDialog(context);
        setState(() => this._connected = false);
      },
      onSuccess: () => setState(() => this._connected = true));

  @override
  Widget build(BuildContext context){
    if (_checkConnection) {
      _initCheckConnection(context);
    }
    if (this._connected) {
      return _showPage();
    } else {
      return _showNotConnectedPage();
    }
  }

}
