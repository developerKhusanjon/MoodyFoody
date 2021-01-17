import 'dart:convert';
import 'package:flutter/material.dart';
import 'contact.dart';
import 'fast_food.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Coding Time',
    theme: ThemeData(primarySwatch: Colors.grey,fontFamily: "Raleway"),
    home: ParsingPage(),
  ));
}

class ParsingPage extends StatefulWidget {
  @override
  _ParsingPageState createState() => _ParsingPageState();
}

class _ParsingPageState extends State<ParsingPage> {
  Future<List<Contact>> getContactsFromJSON(BuildContext context) async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString("assets/contacts.json");
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((e) {
      return Contact.fromJSON(e);
    }).toList();
  }

  Future<List<Contact>> getContactsFromXML(BuildContext context) async {
    String xmlString =
        await DefaultAssetBundle.of(context).loadString("assets/contact.xml");
    var raw = xml.parse(xmlString);
    var elements = raw.findAllElements("contact");

    return elements
        .map((element) => Contact(
            element.findElements("name").first.text,
            element.findElements("email").first.text,
            int.parse(element.findElements("age").first.text)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getContactsFromJSON(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Contact> contacts = snapshot.data;
              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (_, index) => ListTile(
                        title: Text(
                          contacts[index].name,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(contacts[index].email),
                      ));
            } else
              return CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
          },
        ),
      ),
    );
  }
}
