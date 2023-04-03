import 'package:firebase_auth/firebase_auth.dart';
import 'package:notpad_flutter/modal/firebase_auth_helper.dart';
import 'package:notpad_flutter/views/app_style.dart';
import 'package:notpad_flutter/views/note_card.dart';
import 'package:notpad_flutter/views/note_editor.dart';
import 'package:notpad_flutter/views/note_reader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  CircleAvatar(
                    radius: 70,
                    foregroundImage: (user?.photoURL != null)
                        ? NetworkImage(user?.photoURL as String)
                        : null,
                  ),
                  Divider(color: Colors.black,height: 50),
                  Text("Username :${user?.displayName}"),
                  Text("Email:${user?.email}"),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              setState(() {
                Scaffold.of(context).openDrawer();
              });
            },
            child: Image.asset(
              "assets/images/menu.png",
              scale: 18,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          "FireNotes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        actions: [
          TextButton(
            child: Text(
              "Log out",
            ),
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.logOut();

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login', (route) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Note",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Notbook")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      width: 400,
                      height: 800,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteReader(note),
                                    ),
                                  );
                                }, note))
                            .toList(),
                      ),
                    );
                  }
                  return Text(
                    "there's no Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditor()),
          );
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
