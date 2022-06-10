import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'activity_model.dart';
import 'constants.dart';
import 'database_provider.dart';

class TrackCardInput extends StatefulWidget {
  const TrackCardInput({Key key}) : super(key: key);

  @override
  _TrackCardInputState createState() => _TrackCardInputState();
}

class _TrackCardInputState extends State<TrackCardInput> {
  String title;
  String description;
  int days;
  int target;
  DateTime date;

  TextEditingController titleController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addActivity(ActivityModel activity) {
    DatabaseProvider.db.addNewActivity(activity);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            // color: Colors.pink,
            height: size.height * .20,
            width: size.width,
            margin: EdgeInsets.only(left: size.width * .10),
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                "Add Activity",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: "Caviar",
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30, left: size.width * .10),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title (Ex. Reading, Exercise, Biking...",
                  hintStyle: TextStyle(fontSize: 23)),
              style: TextStyle(fontSize: 30, fontFamily: "Caviar"),
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30, left: size.width * .10),
            child: TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              controller: targetController,
              decoration: InputDecoration(
                hintText: "What is your Target ? 10 days, 20 days...",
                hintStyle: TextStyle(fontSize: 18),
              ),
              style: TextStyle(fontSize: 30, fontFamily: "Caviar"),
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30, left: size.width * .10),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Short Description",
                  hintStyle: TextStyle(fontSize: 20)),
              style: TextStyle(fontSize: 20, fontFamily: "Caviar"),
            ),
          ),
          // Container(
          //   width: size.width,
          //   margin: EdgeInsets.only(top: 30, left: size.width * .10),
          //   child: Text(
          //     "Today is " + DateFormat('dd-MM-yyyy').format(DateTime.now()),
          //     style: TextStyle(fontSize: 25, fontFamily: "Caviar"),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 0),
            child: SizedBox(
              height: 120.0,
              width: 120.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
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
                        content: Text("Activity/Description is Empty!"),
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
                      setState(() {
                        title = titleController.text;
                        description = descriptionController.text;
                        target = int.parse(targetController.text);
                        date = DateTime.now();
                      });
                      var lastupdated = "";
                      ActivityModel activity = ActivityModel(
                          title: title,
                          description: description,
                          target: target,
                          days: 0,
                          creationDate: date,
                          lastUpdated: lastupdated);
                      addActivity(activity);
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/", (route) => false);
                    }
                  },
                  backgroundColor: Color(0xFF2F4858),
                  label: const Text("Save"),
                  icon: const Icon(Icons.save),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
