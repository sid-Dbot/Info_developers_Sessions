import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/album.dart';

//get Reauest---------------------
Future<Album> futureAlbum() async {
  http.Response res =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  final Album data = jsonDecode(res.body);
  return data;
}

//POST REQUEST-------
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Create Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Create Data Example'),
            ),
            body: Container(
                child: FutureBuilder(
                    future: futureAlbum(),
                    builder: (context, snapshot) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, int i) => Container(
                                child: Text(
                                  snapshot.data!.title.toString(),
                                ),
                              ));
                    }))));
  }

  // Column buildColumn() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       TextField(
  //         controller: _controller,
  //         decoration: const InputDecoration(hintText: 'Enter Title'),
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           // setState(() {
  //           //   futureAlbum ()= createAlbum(_controller.text);
  //           // });
  //         },
  //         child: const Text('Create Data'),
  //       ),
  //     ],
  //   );
  // }

//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: futureAlbum(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.title);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
}
