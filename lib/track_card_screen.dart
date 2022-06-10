import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifetrack_app/database_provider.dart';

import 'constants.dart';

class TrackCardScreen extends StatefulWidget {
  const TrackCardScreen({Key key}) : super(key: key);

  @override
  _TrackCardScreenState createState() => _TrackCardScreenState();
}

class _TrackCardScreenState extends State<TrackCardScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final List activity = ModalRoute.of(context).settings.arguments as List;
    var currentMonth = DateFormat.MMMM().format(DateTime.now());
    var currentDay = DateFormat('d').format(DateTime.now());
    var currentdays = activity[2].toString();
    var target = activity[3].toString();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                // color: Colors.pink,
                height: size.height * .25,
                width: size.width * .50,
                margin: EdgeInsets.only(left: size.width * .10),
                child: Container(
                  margin: EdgeInsets.only(top: 110),
                  child: activity[1].length > 8
                      ? Text(
                          activity[1],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontFamily: "Caviar",
                          ),
                        )
                      : Text(
                          activity[1],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 45.0,
                            fontFamily: "Caviar",
                          ),
                        ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 55, left: 30),
                child: SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        DatabaseProvider.db.deleteActivity(activity[0]);
                        //Navigate to Note Creation Screen
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      },
                      backgroundColor: Color(0xFF2F4858),
                      child: const Icon(Icons.delete),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(
              bottom: 30,
              left: size.width * .10,
              right: size.width * .10,
            ),
            child: Text(
              activity[6].toString(),
              style: TextStyle(fontSize: 20, fontFamily: "Caviar"),
            ),
          ),
          Row(
            children: [
              Container(
                height: size.height * .20,
                width: size.width * 0.4,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                margin: EdgeInsets.only(
                    left: size.width * .10, right: size.width * .10),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          activity[2].toString(),
                          style: TextStyle(
                              fontSize: 50.0,
                              fontFamily: "Caviar",
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 43, top: 8),
                        child: Text(
                          "Days",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: "Caviar",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF2F4858),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  "$currentdays/$target",
                  style: TextStyle(
                      fontFamily: "Caviar", color: Colors.white, fontSize: 28),
                ),
              )
            ],
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30, left: size.width * .10),
            child: activity[5] == ""
                ? Text(
                    "Last Entry: None",
                    style: TextStyle(fontSize: 30, fontFamily: "Caviar"),
                  )
                : Text(
                    "Last Entry: " + currentMonth + " " + activity[5],
                    style: TextStyle(fontSize: 30, fontFamily: "Caviar"),
                  ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30, left: size.width * .10),
            child: Text(
              "Started: " + activity[4],
              style: TextStyle(fontSize: 30, fontFamily: "Caviar"),
            ),
          ),
          activity[2] == activity[3]
              ? Container(
                  margin: EdgeInsets.only(top: 50, right: size.width * .4),
                  child: SizedBox(
                    height: 60,
                    width: 180,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFdcdcdd),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Caviar",
                            fontSize: 25,
                          ),
                        )),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 50, right: size.width * .4),
                  child: SizedBox(
                    height: 60,
                    width: 180,
                    child: ElevatedButton(
                        onPressed: () {
                          if (activity[5] == currentDay) {
                            AlertDialog alert = AlertDialog(
                              contentTextStyle: TextStyle(
                                  fontFamily: "Caviar",
                                  color: Colors.black,
                                  fontSize: 15),
                              title: Text(
                                "Alert",
                                style: TextStyle(
                                    fontFamily: "Caviar",
                                    color: Color(0xFF2F4858),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              content: Text("Already made an entry for Today!"),
                              elevation: 24.0,
                              backgroundColor: kBackgroundColor,
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          } else {
                            var newDays = activity[2] + 1;
                            DatabaseProvider.db
                                .updateActivityDay(activity[0], newDays);
                            DatabaseProvider.db.updateLastUpdated(activity[0]);
                            //Navigate to Note Creation Screen
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFdcdcdd))),
                        child: Text(
                          "Add a Day",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Caviar",
                            fontSize: 25,
                          ),
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}
