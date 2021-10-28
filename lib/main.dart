import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Jogo da memoria'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int points = 0;
  Widget buttonTryAgain = Text("");
  List _alternatives = [
    {
      "name": "lion",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Lion-1.jpg/640px-Lion-1.jpg"
    },
    {
      "name": "cat",
      "image":
          "https://i2.wp.com/profissaobiotec.com.br/wp-content/uploads/2020/01/cat-4262034_1920.jpg?fit=1088%2C725&ssl=1"
    },
    {
      "name": "dog",
      "image":
          "https://skycms.s3.amazonaws.com/images/5495100/cachorro-card-3.png"
    },
    {
      "name": "piramid",
      "image":
          "http://revistagalileu.globo.com/Revista/Galileu2/foto/0,,66086641,00.jpg"
    }
  ];

  _buildAlternatives(alternatives) {
    List _listShuffled = List.empty(growable: true);
    List _listNormal = List.empty(growable: true);
    List<Widget> _listW = List.empty(growable: true);
    int length = alternatives.length;

    alternatives.forEach((alternative) {
      _listShuffled.add(alternative);
      _listNormal.add(alternative);
    });

    _listShuffled.shuffle();

    for (int i = 0; i < length; i++) {
      print(_listShuffled[i]['name']);
      _listW.add(_draggableCards(_listShuffled[i], _listNormal[i]));
    }

    return Row(children: _listW);
  }

  _draggableCards(_listShuffled, _listNormal) {
    Widget targetAnswer = Text(_listNormal['name'].toString().toUpperCase());

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Draggable(
          data: _listShuffled['name'],
          child: Image(
            width: 95,
            height: 95,
            image: NetworkImage(
              _listShuffled['image'],
            ),
          ),
          feedback: Image(
            width: 95,
            height: 95,
            image: NetworkImage(
              _listShuffled['image'],
            ),
          ),
        ),
        DragTarget(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: 95,
              width: 95,
              color: Colors.cyan,
              child: targetAnswer,
            );
          },
          onWillAccept: (value) => value == _listNormal['name'],
          onAccept: (value) {
            print(points);
            points++;
            targetAnswer = Image(
              image: NetworkImage(
                _listNormal['image'],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(6),
        height: 250,
        child: _buildAlternatives(_alternatives),
      ),
      floatingActionButton: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue[400])),
        onPressed: () => {
          setState(() => {}),
          points = 0,
        },
        child: Text(
          "Jogar novamente",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
