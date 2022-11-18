import 'package:author_registeration_app/helper/cloud_firebase_helper.dart';
import 'package:author_registeration_app/style/app_style.dart';
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
  static GlobalKey<FormState> updateformkey = GlobalKey<FormState>();
  static TextEditingController auth_nameController = TextEditingController();
  static TextEditingController content_Controller = TextEditingController();

  String auth_name = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      //backgroundColor: Colors.black,
      backgroundColor: Colors.red.shade100,
      //backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
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
        //backgroundColor: Colors.red.shade100,
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
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      CloudFirestoreHelper.cloudFirestoreHelper.selectRecord(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      QuerySnapshot? data = snapshot.data;
                      List<QueryDocumentSnapshot> list = data!.docs;
                      return Container(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 300,
                                  childAspectRatio: 0.10),
                          // childAspectRatio:
                          //     MediaQuery.of(context).size.width),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.network(
                                      '${list[i]['image']}',
                                      scale: 30,
                                    ),
                                  ),
                                  Text(
                                    "${list[i]['a_name']}",
                                    style: AppStyle.mainTitle,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${list[i]['b_content']}",
                                    style: AppStyle.mainContent,
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await CloudFirestoreHelper
                                              .cloudFirestoreHelper
                                              .deleteRecord(
                                            id: list[i].id,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          updateData(id: list[i].id);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Text(
                      "No Authors Notes ...",
                      style: GoogleFonts.nunito(color: Colors.white),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Color(0xfffcca3f),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthorEditor_Page(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.red.shade100,
          size: 28,
        ),
      ),
    );
  }

  updateData({required String id}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: updateformkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text("Update"),
                ),
                TextFormField(
                  controller: auth_nameController,
                  onSaved: (val) {
                    auth_name = val!;
                  },
                  validator: (val) {
                    (val!.isEmpty) ? 'Enter your title first...' : null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Title",
                    label: Text("Enter Your title"),
                  ),
                ),
                TextFormField(
                  controller: content_Controller,
                  onSaved: (val) {
                    content = val!;
                  },
                  validator: (val) {
                    (val!.isEmpty) ? 'Enter your context first' : null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Context",
                    label: Text("Enter Your context"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        if (updateformkey.currentState!.validate()) {
                          updateformkey.currentState!.save();

                          Map<String, dynamic> update = {
                            'a_name': auth_name,
                            'b_content': content,
                          };

                          CloudFirestoreHelper.cloudFirestoreHelper
                              .updateRecord(id: id, updateData: update);

                          auth_nameController.clear();
                          content_Controller.clear();

                          setState(() {
                            auth_name = "";
                            content = "";
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Update"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        auth_nameController.clear();
                        content_Controller.clear();

                        setState(() {
                          auth_name = "";
                          content = "";
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
