import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manager_app/Custom/TodoCard.dart';
import 'package:task_manager_app/pages/AddTodo.dart';
import 'package:task_manager_app/pages/signup_page.dart';

import '../Service/Auth_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            child: SizedBox(
                child: ClipOval(
              child: Image.asset("assets/default_profile.png"),
            )),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => AddTodo()));
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.purple])),
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
          ),
        ),
      ]),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TodoCard(
                  title: "Lets roll",
                  check: true,
                  iconBgColor: Colors.white,
                  iconColor: Colors.red,
                  iconData: Icons.alarm,
                  time: "10 AM",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () async {
//                 await authClass.logout();
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (builder) => SignupPage()),
//                     (route) => false);
//               })
