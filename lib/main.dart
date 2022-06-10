import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lifetrack_app/constants.dart';

import 'database_provider.dart';
import 'track_card.dart';
import 'track_card_input.dart';
import 'track_card_screen.dart';

void main() async {
  runApp(
    MaterialApp(
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: 'assets/images/logo.png',
        splashIconSize: 200,
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: kBackgroundColor,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      // routes
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/TrackCardScreen": (context) => TrackCardScreen(),
        "/TrackCardInput": (context) => TrackCardInput(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getActivities() async {
    final notes = await DatabaseProvider.db.getActivities();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .38,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: size.width * .06),
            child: Text(
              "LifeTrack",
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: "Caviar",
              ),
            ),
          ),
          Container(
            // color: Colors.pink,
            height: size.height,
            margin: EdgeInsets.only(
              top: size.height * .25,
              right: size.width * .06,
              left: size.width * .06,
            ),
            child: Container(
              child: FutureBuilder(
                future: getActivities(),
                builder: (context, activityData) {
                  switch (activityData.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      break;
                    case ConnectionState.done:
                      {
                        if (!activityData.hasData) {
                          return const Center(
                            child: Text(
                                "You don't have any notes yet, create one!"),
                          );
                        } else {
                          return activityData.data == Null
                              ? Center(
                                  child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * .1),
                                      width: 200.00,
                                      height: 200.00,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: ExactAssetImage(
                                              'assets/images/cat.png'),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Click on + Icon to start!",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Caviar",
                                      ),
                                    ),
                                  ],
                                ))
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 300,
                                          childAspectRatio: 0.9,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: activityData.data.length,
                                  itemBuilder: (context, index) {
                                    String title =
                                        activityData.data[index]['title'];
                                    String description =
                                        activityData.data[index]['description'];
                                    int days = activityData.data[index]['days'];
                                    int id = activityData.data[index]['id'];
                                    int target =
                                        activityData.data[index]['target'];
                                    String creationDate = activityData
                                        .data[index]['creationDate'];
                                    String lastUpdated =
                                        activityData.data[index]['lastUpdated'];
                                    return TrackCard(
                                      id: id,
                                      title: title,
                                      description: description,
                                      days: days,
                                      target: target,
                                      creationDate: creationDate,
                                      lastUpdated: lastUpdated,
                                    );
                                  },
                                );
                        }
                      }
                      break;
                    default:
                      {
                        return const Center(
                          child:
                              Text("You don't have any notes yet, create one!"),
                        );
                      }
                  }
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height * .87, left: size.width * 0.75),
            child: SizedBox(
              height: 70.0,
              width: 70.0,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {
                    //Navigate to Note Creation Screen
                    Navigator.pushNamed(context, "/TrackCardInput");
                  },
                  backgroundColor: Color(0xFF2F4858),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
