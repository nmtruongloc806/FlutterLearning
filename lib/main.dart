import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class RandomEnglistWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomEnglistWordsState();
  }
}

class RandomEnglistWordsState extends State<RandomEnglistWords> {
  final _words = <WordPair>[];
  final _checkedWords = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("This is Header's title"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushToSavedWordsScreen,
          )
        ],
      ),
      body: new Center(
        child: new ListView.builder(
          itemBuilder: (context, index) {
            if (index >= _words.length) {
              _words.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_words[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(WordPair wordPair, int index) {
    final textcolor = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedWords.contains(wordPair);
    return new ListTile(
      leading: new Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: textcolor,
      ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(fontSize: 22.0, color: textcolor),
      ),
      onTap: () {
        setState(() {
          if (isChecked) {
            _checkedWords.remove(wordPair);
          } else {
            _checkedWords.add(wordPair);
          }
        });
      },
    );
  }

  _pushToSavedWordsScreen() {
    print("mtl da print dc");
    final functionBuilder = (context) {
      final listTitles = _checkedWords.map((wordPair) {
        return new ListTile(
          title: new Image.asset(
            "images/icon_flutter.png",
            width: 40.0,
            height: 40.0,
          ),
          subtitle: new Text(
            wordPair.asUpperCase,
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        );
      });

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("List checked words"),
        ),
        body: new ListView(children: listTitles.toList()),
      );
    };

    final pageRoute = new MaterialPageRoute(builder: functionBuilder);

    Navigator.of(context).push(pageRoute);
  }
}

class MyApp extends StatelessWidget {
  // các components của ui gọi là widget

// chạy lần đầu để return ui implement từ StatelessWidget
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();

    // TODO: implement build
    return new MaterialApp(
        title: "This is my first MTL App", home: new RandomEnglistWords());
  }
}
