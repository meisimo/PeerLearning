import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/widgets/tarjetas/mini_card.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator.dart';
import 'package:peer_programing/src/widgets/loading.dart';

class RecomendedPage extends StatelessWidget {
  RecomendedPage({Key key}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return MainLayout(
      title: "Favoritos",
      body: Expanded(
          child: RecomendedMentorByCategoryList(),
        ),
      defaultVerticalScroll: false,
    );
  }
}

class RecomendedMentorByCategoryList extends StatefulWidget{
  @override
  _RecomendedMentorByCategoryList createState() =>
    _RecomendedMentorByCategoryList();

}

class _RecomendedMentorByCategoryList extends State<RecomendedMentorByCategoryList>{
  List<UserModel> _recomendedUsers;

  Widget _recomendedList() =>
  ListView(
      children: <Widget>[
        _categoryRow(
          "Tutores recomendados", LightColor.orange, LightColor.orange),
        _featuredRowA(),
        SizedBox(height: 0),
        // _categoryRow(
        //   "Temas recomendados", LightColor.purple, LightColor.darkpurple),
        // _featuredRowB()
    ],);

  @override
  Widget build(BuildContext context) =>
    StreamBuilder(
      stream: UserModel.snapshot(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) 
            return new Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting )
            return Loading();
          if (_recomendedUsers == null){
            Future.wait(UserModel.listFromSnapshot(snapshot.data.documents)).then((users) =>setState((){_recomendedUsers = users.map<UserModel>((u)=>u).toList();}));
            return Loading();  
          }

          return _recomendedUsers == null ? Loading(): _recomendedList();
      });
  


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
          TagChip("See all", primary, onTap: () => print("See all"),)
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
          children: _recomendedUsers.map<Widget>((user)=>
             MiniCard(
                primary: LightColor.orange,
                backWidget: Decorator.generateDecoration(),
                chipColor: LightColor.orange,
                chipText1: user.name,
                chipText2: "8 Cources",
                isPrimaryCard: true,
                imgPath: user.imgPath != null ? user.imgPath :
                    "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
          ).toList()
          
          // <Widget>[

          //   MiniCard(
          //       primary: LightColor.orange,
          //       backWidget: Decorator.generateDecoration(),
          //       chipColor: LightColor.orange,
          //       chipText1: "Find the right degree for you",
          //       chipText2: "8 Cources",
          //       isPrimaryCard: true,
          //       imgPath:
          //           "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
          //   MiniCard(
          //       primary: Colors.white,
          //       chipColor: LightColor.seeBlue,
          //       backWidget: Decorator.generateDecoration(),
          //       chipText1: "Become a data scientist",
          //       chipText2: "8 Cources",
          //       imgPath:
          //           "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*"),
          //   MiniCard(
          //       primary: Colors.white,
          //       chipColor: LightColor.lightOrange,
          //       backWidget: Decorator.generateDecoration(),
          //       chipText1: "Become a digital marketer",
          //       chipText2: "8 Cources",
          //       imgPath:
          //           "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
          //   MiniCard(
          //       primary: Colors.white,
          //       chipColor: LightColor.seeBlue,
          //       backWidget: Decorator.generateDecoration(),
          //       chipText1: "Become a machine learner",
          //       chipText2: "8 Cources",
          //       imgPath:
          //           "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
          // ],
        ),
      ),
    );
  }

  Widget _featuredRowB() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            MiniCard(
                primary: LightColor.seeBlue,
                chipColor: LightColor.seeBlue,
                backWidget: Decorator.generateDecoration(),
                chipText1: "English for career development ",
                chipText2: "8 Cources",
                isPrimaryCard: true,
                imgPath:
                    "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.lightpurple,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Bussiness foundation",
                chipText2: "8 Cources",
                imgPath:
                    "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.lightOrange,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Excel skill for business",
                chipText2: "8 Cources",
                imgPath:
                    "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.seeBlue,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Beacame a data analyst",
                chipText2: "8 Cources",
                imgPath:
                    "https://img.alicdn.com/imgextra/i4/52031722/O1CN0165X68s1OaiaYCEX6U_!!52031722.jpg"),
            MiniCard(
                primary: LightColor.seeBlue,
                chipColor: LightColor.seeBlue,
                backWidget: Decorator.generateDecoration(),
                chipText1: "English for career development ",
                chipText2: "8 Cources",
                isPrimaryCard: true,
                imgPath:
                    "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.lightpurple,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Bussiness foundation",
                chipText2: "8 Cources",
                imgPath:
                    "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.lightOrange,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Excel skill for business",
                chipText2: "8 Cources",
                imgPath:
                    "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
            MiniCard(
                primary: Colors.white,
                chipColor: LightColor.seeBlue,
                backWidget: Decorator.generateDecoration(),
                chipText1: "Beacame a data analyst",
                chipText2: "8 Cources",
                imgPath:
                    "https://img.alicdn.com/imgextra/i4/52031722/O1CN0165X68s1OaiaYCEX6U_!!52031722.jpg"),
          ],
        ),
      ),
    );
  }

}