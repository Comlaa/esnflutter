import 'package:flutter/material.dart';

class FixtureWidget extends StatefulWidget {
  final String team1;
  final String team2;
  final String result;
  final String matchTime;
  final String category;

  FixtureWidget(
    this.team1,
    this.team2,
    this.result,
    this.matchTime,
    this.category,
  );

  @override
  _FixtureWidgetState createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Card(
        color: Colors.blue.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          height: 100,
          width: 300,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  right: 15,
                  left: 15,
                ),
                child: Text(
                  widget.team1 + ' ' + widget.result + ' ' + widget.team2,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  right: 15,
                  left: 15,
                ),
                child: Text(
                  'Odigran: ' + widget.matchTime,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
