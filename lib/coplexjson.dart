import 'dart:convert';
import 'package:flutter/services.dart';
import 'model.dart';
import 'package:flutter/material.dart';


class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

//Get Data Using API with JsonPhoto Model
Future<List<UserModel>> fetchUsers() async {
  final dataString = await rootBundle.loadString('assets/nested.json');
  // Decode to json
  final List<dynamic> json = jsonDecode(dataString);

  // Go through each post and convert json to Post object.
  final allUserModel = <UserModel>[];
  for (var o in json) {
    allUserModel.add(UserModel.fromJson(o));
  }
  return allUserModel;
}

class _ComplexJsonState extends State<ComplexJson> {
  List<UserModel> _users = <UserModel>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        print(_users.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (!_isLoading) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Text(_users[index].id.toString()),
                title: Text(_users[index].name.toString()),
                subtitle: Text(_users[index].address!.city.toString()),
                trailing: Text(_users[index].address!.zipcode.toString()),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        itemCount: _users.length,
      ),
    );
  }
}
