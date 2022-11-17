import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

class AuthorReader_Page extends StatefulWidget {
  AuthorReader_Page({
    required this.doc,
    Key? key,
  }) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<AuthorReader_Page> createState() => _AuthorReader_PageState();
}

class _AuthorReader_PageState extends State<AuthorReader_Page> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              widget.doc["a_name"],
              style: AppStyle.mainTitle,
            ),
            // const SizedBox(height: 4),
            // Text(
            //   widget.doc["b_name"],
            //   style: AppStyle.dateTitle,
            // ),
            const SizedBox(height: 28),
            Text(
              widget.doc["b_content"],
              style: AppStyle.mainTitle,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
