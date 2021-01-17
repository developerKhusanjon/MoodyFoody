import 'file:///D:/trash/beginner_course_UI/lib/responsive_part/sizeInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveWidget extends StatelessWidget {
  final AppBar appBar;
  final Drawer drawer;
  final Widget Function(BuildContext context,SizeInformation constraints) builder;
  ResponsiveWidget({@required this.builder, this.appBar, this.drawer});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark
    ));

    SizeInformation information = SizeInformation(height,width,orientation);

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        drawer: drawer,
        resizeToAvoidBottomInset: false,
        body: Builder(builder:(context) => builder(context,information)),
      ),
    );
  }
}
