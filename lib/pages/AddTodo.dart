import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.arrow_left),
                color: Colors.white,
                iconSize: 28,
                padding: const EdgeInsets.only(left: 10),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "New Task",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Task Title"),
                    const SizedBox(
                      height: 12,
                    ),
                    textField(55, "Text title"),
                    const SizedBox(
                      height: 20,
                    ),
                    label("Task Type"),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        chipData("Important", 0xffcb1104),
                        const SizedBox(
                          width: 15,
                        ),
                        chipData("Planned", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    label("Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    textField(155, "Description"),
                    const SizedBox(
                      height: 20,
                    ),
                    label("Category"),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData("Food", 0xffff6d6e),
                        const SizedBox(
                          width: 15,
                        ),
                        chipData("Workout", 0xfff29732),
                        const SizedBox(
                          width: 15,
                        ),
                        chipData("Work", 0xff6557ff),
                        const SizedBox(
                          width: 15,
                        ),
                        chipData("Miscellaneous", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    button(),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ])),
      child: const Center(
        child: Text(
          "Add task",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget chipData(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: 0.2),
    );
  }

  Widget textField(double height, String text) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 46, 62),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
