import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deinort_app/widgets/newsList.dart';

void main() => runApp(App());


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Deinort",
      home: NewsList()
    );
  }

}
