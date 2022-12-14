import 'package:api_service/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesForm extends StatefulWidget {
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController emailcontroller = TextEditingController();
  static TextEditingController idcontroller = TextEditingController();
  static TextEditingController officecontroller = TextEditingController();
  static TextEditingController complaincontroller = TextEditingController();
  static TextEditingController desccontroller = TextEditingController();

  @override
  State<MoviesForm> createState() => _MoviesFormState();
}

class _MoviesFormState extends State<MoviesForm> {
  Future? _sentdata;
  String title = "Please fill the details:";
  String saveddata = '';
  var data;

  // var _data = {};

  List<String> textfieldData = [
    'name',
    'email',
    'national_id',
    "complain_office",
    'complain_title',
    'complain_decs',
  ];

  List<IconData> iconfieldData = [
    Icons.person,
    Icons.email,
    Icons.nat_outlined,
    Icons.local_post_office_rounded,
    Icons.title,
    Icons.description_sharp
  ];

  List<TextEditingController> textControllers = [
    MoviesForm.namecontroller,
    MoviesForm.emailcontroller,
    MoviesForm.idcontroller,
    MoviesForm.officecontroller,
    MoviesForm.complaincontroller,
    MoviesForm.desccontroller
  ];

  submit() async {
    final prefs = await SharedPreferences.getInstance();
    final String? title = prefs.getString('title');
    final String? saveddata = prefs.getString("data");
    await prefs.setString('title', 'Feedback recorded:');

    var data = {
      "name": MoviesForm.namecontroller.text,
      "email": MoviesForm.emailcontroller.text,
      "national_id": MoviesForm.idcontroller.text,
      "complain_office": MoviesForm.officecontroller.text,
      "complain_title": MoviesForm.complaincontroller.text,
      "complain_desc": MoviesForm.desccontroller.text
    };
    //await prefs.setString('saveddata', data);
    setState(() {
      _sentdata = Apiservice().postData(data);
    });

    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
              ),
              (_sentdata == null) ? textFields() : SucessScreen(),
              ElevatedButton(onPressed: submit, child: const Text('Submit'))
            ],
          ),
        ));
  }

  ListView textFields() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: textfieldData.length,
        itemBuilder: (context, index) {
          return customTextField(
              label: textfieldData[index],
              icon: iconfieldData[index],
              texteditingcontroller: textControllers[index]);
        });
  }

  FutureBuilder SucessScreen() {
    return FutureBuilder(
      future: _sentdata,
      builder: (context, snapshot) => (snapshot.hasData)
          ? Text(saveddata)
          : const CircularProgressIndicator(),
    );
  }
}

class customTextField extends StatelessWidget {
  String label;
  final TextEditingController texteditingcontroller;
  final IconData icon;

  customTextField(
      {required this.label,
      required this.icon,
      required this.texteditingcontroller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 9,
                  color: Colors.blueGrey,
                  offset: Offset(2, 4),
                  spreadRadius: 4)
            ]),
        child: TextField(
            controller: texteditingcontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                ),
                prefixIconColor: Colors.lightBlueAccent,
                labelText: label)),
      ),
    );
  }
}
