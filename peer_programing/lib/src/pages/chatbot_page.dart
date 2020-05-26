import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/pages/login_page.dart';
import 'package:peer_programing/src/pages/user_page.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/chatMessages.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/utils/connection.dart';

class Chatbot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatbotState();
  }
}

class ChatbotState extends State<Chatbot> {
  static final String CHAT_BOT_NAME = "Peer chat";
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Chat',
      withBottomNavBar: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 245,
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                  shrinkWrap: true,
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Escribe tu mensaje"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  color: LightColor.purple,
                  onPressed: () => _textController.text != ""
                      ? _handleSubmitted(_textController.text)
                      : null),
            ),
          ],
        ),
      ),
    );
  }

  void response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/DialogCredentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.spanish);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = ChatMessage(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: CHAT_BOT_NAME,
      type: false,
      extra: null,
    );
    Map<String, dynamic> params = response.queryResult.parameters;
    if (params.containsKey('tutoria')) {
      if (params.values.first == "listar") {
        message.extra = GestureDetector(
          child: Text('Pulsa aqui para ver las tutorias',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline)),
          onTap: () => Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => new HomePage())),
        );
      }
    }
    if (params.containsKey('Perfil')) {
      if (params.values.first == "mostrar") {
        UserModel user = await UserModel.getCurrentUser();
        if (user == null) {
          message.extra = GestureDetector(
            child: Text('Pulsa aqui para iniciar sesion',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline)),
            onTap: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => new LoginPage())),
          );
        } else {
          message.extra = GestureDetector(
            child: Text('Pulsa aqui para acceder a tu perfil',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline)),
            onTap: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => new UserPage())),
          );
        }
      }
    }

    setState(() {
      _messages.insert(0, message);
    });
  }

  void responseNoConection(){
    setState(() {
      _messages.insert(0, ChatMessage(
        text: "Lo siento, parece que en este momento no tienes conexión a internet :( Revisa tu conexión e intentalo más tarde.",
        name: CHAT_BOT_NAME,
        type: false,
      ));
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "Tú",
      type: true,
      extra: null,
    );
    setState(() {
      _messages.insert(0, message);
    });
    handleConnectivity(
      onSuccess: () => response(text),
      onError: () => responseNoConection()
    );
  }
}
