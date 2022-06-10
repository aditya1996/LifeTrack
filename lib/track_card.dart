import 'package:flutter/material.dart';
import 'constants.dart';

class TrackCard extends StatelessWidget {
  final String title;
  final String description;
  final int days;
  final int target;
  final int id;
  final String creationDate;
  final String lastUpdated;
  const TrackCard({
    Key key,
    this.title,
    this.description,
    this.days,
    this.target,
    this.id,
    this.creationDate,
    this.lastUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/TrackCardScreen",
          arguments: [
            id,
            title,
            days,
            target,
            creationDate,
            lastUpdated,
            description,
          ],
        );
        print(lastUpdated);
      },
      child: Container(
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25, left: 75),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  children: days != target
                      ? [
                          Text(
                            days.toString(),
                            style:
                                TextStyle(fontSize: 35, fontFamily: "Caviar"),
                          ),
                          Text(
                            "Days",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caviar",
                            ),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 20),
                            child: Icon(Icons.check),
                          ),
                        ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: "Caviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
