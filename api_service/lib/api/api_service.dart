import 'dart:convert';

import 'package:api_service/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DatasPages extends StatelessWidget {
  const DatasPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies List"),
      ),
      body: FutureBuilder(
        future: ApiService().getData(),
        builder: ((context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                            color: Colors.black,
                          )
                        ]),
                    child: Card(
                      elevation: 7,
                      child: ListTile(
                        leading: Text(
                          snapshot.data![index].id.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        title: Image.network(
                          snapshot.data![index].imgURL.toString(),
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        // Text(snapshot.data![index].name.toString()),
                        // subtitle: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(snapshot.data![index].genre.toString()),
                        //     Text(snapshot.data![index].released.toString()),
                        //   ],
                        // ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              snapshot.data![index].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline),
                            ),
                            Text(snapshot.data![index].genre.toString()),
                            Text(snapshot.data![index].released.toString()),
                          ],
                        ),
                      ),
                    ));
              });
        }),
      ),
    );
  }
}
