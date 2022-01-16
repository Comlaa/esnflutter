import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final String title;
  final String comment;
  final double height;
  final double width;

  CommentWidget(
    this.title,
    this.comment,
    this.height,
    this.width,
  );

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Card(
        color: Colors.blue.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.all(7),
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
                    widget.title.toString(),
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
                  widget.comment.toString(),
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
