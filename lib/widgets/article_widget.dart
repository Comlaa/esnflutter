import 'package:esnflutter/screens/article_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ArticleWidget extends StatefulWidget {
  final String title;
  final String picture;
  bool favorite;
  bool saved;

  ArticleWidget(
    this.title,
    this.picture,
    this.favorite,
    this.saved,
  );

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Card(
        elevation: 10,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ArticleScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: size.width,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: size.width,
                          height: 140,
                          child: Image.memory(base64Decode(widget.picture),
                              fit: BoxFit.fill)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue.shade400,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.favorite = widget.favorite ? false : true;
                            });
                          },
                          child: widget.favorite
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.saved = widget.saved ? false : true;
                            });
                          },
                          child: widget.saved
                              ? Icon(Icons.bookmark)
                              : Icon(Icons.bookmark_border),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
