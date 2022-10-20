//FUTURE AND STREAM DEMO//

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// void main(List<String> args) {
//   runApp(Builderz());
// }

// class Builderz extends StatefulWidget {
//   @override
//   State<Builderz> createState() => _BuilderzState();
// }

// class _BuilderzState extends State<Builderz> {
//   Future<int> _calc(int num) async {
//     await Future.delayed(Duration(seconds: 2));
//     return num + 10;
//   }

//   Stream<int> _stream(int num) async* {
//     while (true) {
//       await Future.delayed(Duration(seconds: 2));
//       yield num++;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           body: Column(children: [
//         Center(
//           child: FutureBuilder(
//               future: _calc(39),
//               builder: (context, snapshot) {
//                 return Text(snapshot.data.toString());
//               }),
//         ),
//         Center(
//           child: StreamBuilder(
//             stream: _stream(20),
//             builder: (context, snapshot) => Text(snapshot.data.toString()),
//           ),
//         )
//       ])),
//     );
//   }
// }