import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ReadJson extends StatefulWidget {
  const ReadJson({Key? key}) : super(key: key);

  @override
  State<ReadJson> createState() => _ReadJsonState();
}

class _ReadJsonState extends State<ReadJson> {
  List _items = [];
  @override
  void initState() {
    super.initState();
    readJson();
  }

// Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
    print(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Json'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: _items.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Text(_items[index]["id"]),
                              title: Text(_items[index]["name"]),
                              subtitle: Text(_items[index]["description"]),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
