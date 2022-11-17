import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

class AuthorEditor_Page extends StatefulWidget {
  const AuthorEditor_Page({Key? key}) : super(key: key);

  @override
  State<AuthorEditor_Page> createState() => _AuthorEditor_PageState();
}

class _AuthorEditor_PageState extends State<AuthorEditor_Page> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  TextEditingController authorController = TextEditingController();
  TextEditingController bcontentController = TextEditingController();
  TextEditingController bnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20),
        child: Column(
          children: [
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Author Name',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            // TextField(
            //   controller: bnameController,
            //   decoration: const InputDecoration(
            //     border: InputBorder.none,
            //     hintText: 'Book Name',
            //   ),
            //   style: AppStyle.mainTitle,
            // ),
            // const SizedBox(
            //   height: 28,
            // ),
            TextField(
              controller: bcontentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Book Context',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          FirebaseFirestore.instance.collection("Authors").add({
            "a_name": authorController.text,
            "b_content": bcontentController.text,
            // "b_name": bnameController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.of(context).pop();
          }).catchError((error) => print("Failed to add new $error"));
        },
        child: const Icon(
          Icons.save_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
