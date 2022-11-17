import 'package:author_registeration_app/screens/author_reader.dart';
import 'package:author_registeration_app/widgets/author_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'author_editor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        // elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/firebaselogo.png",
              scale: 12,
            ),
            const SizedBox(width: 8),
            const Text(
              "FireAuthor Registration App",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        // backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Author Registration Notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Authors")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map((e) => authorCard(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AuthorReader_Page(doc: e),
                                    ),
                                  );
                                }, e))
                            .toList(),
                      );
                    }
                    return Text(
                      "No Authors Notes ...",
                      style: GoogleFonts.nunito(color: Colors.white),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffcca3f),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthorEditor_Page(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
