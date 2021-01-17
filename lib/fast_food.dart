import 'dart:convert';

import 'package:flutter/material.dart';

var bannerItems = ["Burger", "Cheese Chilly", "Noodles", "Pizza"];
var bannerImages = [
  "images/burger.jpg",
  "images/cheesechilly.jpg",
  "images/noodles.jpg",
  "images/pizza.jpg"
];

class FastFoodPage extends StatefulWidget {
  @override
  _FastFoodState createState() => _FastFoodState();
}

class _FastFoodState extends State<FastFoodPage> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = List<Widget>();
      String dateString =
      await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dateString);

      dataJSON.forEach((element) {
        String finalSring = "";
        List<dynamic> foods = element["placeItems"];
        foods.forEach((food) {
          finalSring += food + " | ";
        });
        items.add(Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black,
                  Colors.blueGrey.shade900,
                  Colors.black
                ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade900,
                      spreadRadius: 5,
                      blurRadius: 10),
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  child: Image.asset(
                    element["placeImage"],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: screenwidth - 120,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          element["placeName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          finalSring,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Min. Order: ${element["minOrder"]}",
                          style: TextStyle(
                              fontSize: 12, color: Colors.deepOrange.shade700),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      });

      return items;
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        height: screenheight,
        width: screenwidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        'Foodies',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'CurlyTTF'),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                BannerView(),
                FutureBuilder(
                  future: createList(),
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: snapshot.data,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.fastfood,
          color: Colors.black,
        ),
      ),
    );
  }
}

List<Color> colors = List<Color>(bannerItems.length);

void setShadowColors([index = 1]) {
  for (int i = 0; i < bannerItems.length; i++) {
    colors[i] = Colors.transparent;
  }
  colors[index] = Colors.grey.shade700;
}

class BannerView extends StatefulWidget {
  BannerView() {
    setShadowColors();
  }

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    PageController controller =
    PageController(viewportFraction: 0.8, initialPage: 1);
    List<Widget> banners = List<Widget>();

    for (int i = 0; i < bannerItems.length; i++) {
      var bannerView = Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: colors[i],
                        //offset: Offset(6, 6),
                        blurRadius: 10,
                        spreadRadius: 5)
                  ]),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                bannerImages[i],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bannerItems[i],
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      'More than 40% off',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      width: width,
      height: width * 9 / 16,
      child: PageView(
        onPageChanged: (index) {
          setState(() {
            setShadowColors(index);
          });
        },
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}