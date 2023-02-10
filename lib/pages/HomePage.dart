import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manager_app/Custom/TodoCard.dart';
import 'package:task_manager_app/pages/AddTodo.dart';
import 'package:task_manager_app/pages/signup_page.dart';
import 'package:task_manager_app/pages/view_data.dart';

import '../Service/Auth_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  // var currentUser = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Tasks")
      .where("author", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SizedBox(
                child: ClipOval(
              child: Image.asset("assets/default_profile.png"),
            )),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        const BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const AddTodo()));
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.purple])),
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
          ),
        ),
      ]),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  if (document.isEmpty) {
                    return const Center(
                      child: Text(
                        "You have no tasks",
                      ),
                    );
                  }
                  switch (document["category"]) {
                    case "Food":
                      iconData = Icons.food_bank;
                      iconColor = Colors.red;
                      break;
                    case "Workout":
                      iconData = Icons.fitness_center;
                      iconColor = Colors.teal;
                      break;
                    case "Work":
                      iconData = Icons.laptop;
                      iconColor = const Color.fromARGB(255, 56, 156, 69);
                      break;
                    case "Miscellaneous":
                      iconData = Icons.nature;
                      iconColor = const Color.fromARGB(255, 76, 144, 175);
                      break;
                    default:
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                  }
                  return TodoCard(
                    // userid: currentUser,
                    // userid: currentUser,
                    title: document["title"] ?? "Hey There",
                    check: true,
                    iconBgColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                    time: "10 AM",
                  );
                });
          }),
    );
  }
}
