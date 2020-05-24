import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 

class MentoringFeedBack extends StatefulWidget {
  final Function _onSave;
  final Mentoring _mentoring;

  MentoringFeedBack({@required onSave, @required mentoring})
      : _onSave = onSave,
        _mentoring = mentoring;

  @override
  _MentoringFeedBack createState() =>
      new _MentoringFeedBack(onSave: _onSave, mentoring: _mentoring);
}

class _MentoringFeedBack extends State<MentoringFeedBack> {
  final _formKey = GlobalKey<FormState>();
  final Function _onSave;
  final Mentoring _mentoring;
  double _calification = 0;
  String _comments = '';

  _MentoringFeedBack({@required onSave, @required mentoring})
      : _onSave = onSave,
        _mentoring = mentoring;

  Widget _header() => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 50
      ),
      child: Text(
        "Puntuación",
        style: TextStyle(
          fontSize: 30
        ),
      ),
    ),
  );

  Widget _descripcion() => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 20
    ),
    child: Text(
      "Cuentanos qué tal te há parecido la tutoría de ${_mentoring.name} con ${_mentoring.user.name}",
      style: TextStyle(
        fontSize: 17
      ),
    ),
  );

  Widget _buildDialog(context) =>
    SingleChildScrollView(
      child: 
    Container(
      width: 300,
      child: Column(
        children: <Widget>[
          _header(),
          _descripcion(),
          _feedbackForm(context),    
        ],
    )
      ));
      
  Widget _starsInput() => 
    Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: "Calificación",
            ),
            style: TextStyle(
              fontSize: 15
            ),
            readOnly: true,
            textAlign: TextAlign.center,
            validator: ( (_) => _calification == 0 ? "La califiación más baja es media estrella.":null ),
          ),
          SmoothStarRating(
            allowHalfRating: true,
            onRatingChanged: (v) => setState(() =>_calification = v),
            starCount: 5,
            rating: _calification,
            size: 35.0,
            color: LightColor.orange,
            borderColor: LightColor.orange,
            spacing:0.0
          )
        ],
      ),
    );

  Widget _commentsInput() => 
    Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:5, horizontal: 20),
        child: TextFormField(
        decoration:InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Comentario para ${_mentoring.user.name}",
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 3,
        onChanged: (comments) => _comments = comments ,
      ),
      )
    );

  Widget _submitFeedback(BuildContext context) => 
    Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:10,
        ),
        child: RaisedButton(
          child: Icon(Icons.send),
          color: LightColor.purple,
          onPressed: (){
            if(_formKey.currentState.validate()){
              _onSave(_mentoring, _calification, _comments);
            }
          },
        ),
      ),
    );

  Widget _feedbackForm(BuildContext context) => 
    Form(
      key: _formKey,
      autovalidate: false,
      child: Column(
        children: <Widget>[
          _starsInput(),
          _commentsInput(),
          _submitFeedback(context)
        ]
      ),
    );

  @override
  Widget build(BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(child: _buildDialog(context),),
    );
}
