import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:http/http.dart' as http;

import 'items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodXp',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'FoodXp'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  int listLength = 1;
  int hotelLength = 1;

  late final Future<Items> futureItems;

  @override
  void initState() {
    futureItems = fetchList();
  }

  void setRandom() {
    index = Random().nextInt(listLength);
    setState(() {
      dev.log("length: " + listLength.toString());
    });
  }

  Future<Items> fetchList() async {
    var url = "https://soheshts.github.io/foodxp/items.json";
    var response = await http.get(Uri.parse(url));
    dev.log("feedsresponse: " + response.body.toString());

    if (response.statusCode == 200) {
      return Items.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Items>(
              future: futureItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  listLength = snapshot.data!.itemList!.length;
                  hotelLength =
                      snapshot.data!.itemList!.elementAt(index).hotels!.length;
                  int hotelIndex = Random().nextInt(hotelLength);
                  return Column(
                    children: [
                      Text(
                          snapshot.data!.itemList!
                              .elementAt(index)
                              .name
                              .toString(),
                          style: TextStyle(fontSize: 35, color: Colors.amber)),
                      Text(
                          "from " +
                              snapshot.data!.itemList!
                                  .elementAt(index)
                                  .hotels!
                                  .elementAt(hotelIndex),
                          style: TextStyle(fontSize: 25))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setRandom,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
