import 'file:///D:/trash/beginner_course_UI/lib/responsive_part/responsive_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: AppBar(
          title: Text("This is demo"),
        ),
        builder: (context, properties) {
          return Container(
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: () {
                SnackBar mysnackbar = SnackBar(
                  content: Text("This is a SnackBar"),
                  backgroundColor: Colors.green,
                );
                Scaffold.of(context).showSnackBar(mysnackbar);
              },
              child: Text(
                "Click me",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }
}
