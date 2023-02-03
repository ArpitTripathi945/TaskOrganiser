import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zarity/constants.dart';
import 'package:zarity/model/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zarity/widgets/spinner.dart';

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TaskModel task = TaskModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: buttoncolor,
              ),
              accountName: Text(
                ' Jogn Doe',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                ' Johndoe@gmail.com',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 59.0,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  maxRadius: 55.0,
                  child: CircleAvatar(
                    maxRadius: 50.0,
                    backgroundColor: Color.fromARGB(255, 195, 201, 215),
                    child: Icon(
                      Icons.person,
                      size: 70.0,
                      color: Color.fromARGB(255, 15, 17, 32),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Account"),
              trailing: Icon(Icons.account_circle_rounded),
              onTap: () {},
            ),
            Divider(
              thickness: 0.5,
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings_rounded),
              onTap: () {},
            ),
            Divider(
              thickness: 0.5,
            ),
            ListTile(
              title: Text("Due Tasks"),
              trailing: Icon(Icons.task_rounded),
              onTap: () {},
            ),
            Divider(
              thickness: 0.5,
            ),
            ListTile(
                title: Text("Rate Us"),
                trailing: Icon(Icons.rate_review_rounded),
                onTap: (() {})),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
      body: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
          child: Column(
            children: [
              Row(children: [
                IconButton(
                    iconSize: 35,
                    onPressed: () {
                      _openDrawer();
                    },
                    icon: Icon(Icons.menu)),
                SizedBox(width: 200),
                IconButton(
                    iconSize: 35,
                    onPressed: () {},
                    icon: Icon(Icons.message_outlined)),
                IconButton(
                    iconSize: 35,
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none_outlined)),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "  Good Afternoon,",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: GoogleFonts.openSans().fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "  John Doe",
                    style: TextStyle(
                        fontFamily: GoogleFonts.openSans().fontFamily,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 150),
                  Container(
                    height: 30,
                    width: 86,
                    child: MaterialButton(
                      child: Text(
                        "Show Tasks",
                        style: TextStyle(
                            fontSize: 9,
                            fontFamily: GoogleFonts.openSans().fontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      color: buttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "  View your insights",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),

              //Grid of Tasks
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      ref.orderBy("taskcount", descending: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //checking the connection state, if we still load the data we display a spinner
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Spinner();
                    }
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          Timestamp t = documentSnapshot["time"];
                          String d =
                              DateFormat('EEEE, HH:MM').format(t.toDate());

                          return Container(
                              height: 60,
                              width: 20,
                              child: Card(
                                color: tilecolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Task-" + documentSnapshot["taskcount"],
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontFamily:
                                              GoogleFonts.openSans().fontFamily,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 22),
                                    Container(
                                      height: 30,
                                      width: 95,
                                      child: MaterialButton(
                                        child: Text(
                                          "Open Task",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: GoogleFonts.openSans()
                                                  .fontFamily,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: buttoncolor,
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Container(
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    20.0),
                                                          ),
                                                        ),
                                                        child:
                                                            Column(children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Task Details:",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        GoogleFonts.openSans()
                                                                            .fontFamily),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                documentSnapshot[
                                                                    "taskdata"],
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        GoogleFonts.openSans()
                                                                            .fontFamily),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 12),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Due date:",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        GoogleFonts.openSans()
                                                                            .fontFamily),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                d.toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        GoogleFonts.openSans()
                                                                            .fontFamily),
                                                              ),
                                                            ],
                                                          ),
                                                        ])),
                                                  )));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                    return Text("No tasks pending",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.bold));
                  },
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    '  Your Tasks',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              //List of Tasks
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      ref.orderBy("taskcount", descending: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //checking the connection state, if we still load the data we display a spinner
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Spinner();
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          Timestamp t = documentSnapshot["time"];
                          String d =
                              DateFormat('EEEE, HH:MM').format(t.toDate());

                          return Container(
                              height: 80,
                              width: 100,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  clipBehavior: Clip.antiAlias,
                                  child: ListTile(
                                    tileColor: tilecolor,
                                    title: Text(
                                      "Task-" + documentSnapshot["taskcount"],
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                    subtitle: Text(
                                      d.toString(),
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
                                      child: Container(
                                        height: 20,
                                        width: 81,
                                        child: MaterialButton(
                                          child: Text(
                                            "Open Task",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontFamily:
                                                    GoogleFonts.openSans()
                                                        .fontFamily,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          color: buttoncolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) =>
                                                    SingleChildScrollView(
                                                        child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.0),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                            ),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Task Details:",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blueAccent,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              GoogleFonts.openSans().fontFamily),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 8),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      documentSnapshot[
                                                                          "taskdata"],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              GoogleFonts.openSans().fontFamily),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 12),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Due date:",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blueAccent,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              GoogleFonts.openSans().fontFamily),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 8),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      d.toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              GoogleFonts.openSans().fontFamily),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ])),
                                                    )));
                                          },
                                        ),
                                      ),
                                    ),
                                  )));
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                    return Text("No tasks pending",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.bold));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}
