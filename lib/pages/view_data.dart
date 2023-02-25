import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, this.document, this.docId}) : super(key: key);
  final Map<String, dynamic>? document;
  final String? docId;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController? _titleController;
  TextEditingController? _descController;
  String? type;
  String? category;
  bool? edit = false;
  // ignore: unused_field
  // late final List<Widget> _id = AddTodo(documentId:)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document?["title"] ?? "Hey There";
    _titleController = TextEditingController(text: title);
    _descController =
        TextEditingController(text: widget.document?["description"]);
    type = widget.document?["Tasks"];
    category = widget.document?["category"];
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.arrow_left),
                    color: Colors.white,
                    iconSize: 28,
                    padding: const EdgeInsets.only(left: 10),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit!;
                          });
                        },
                        icon: const Icon(Icons.edit),
                        color: edit! ? Colors.blue : Colors.white,
                        iconSize: 28,
                        padding: const EdgeInsets.only(left: 10),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Tasks")
                              .doc(widget.docId)
                              .delete()
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        iconSize: 28,
                        padding: const EdgeInsets.only(left: 10),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit! ? "Editing" : "View",
                      style: const TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Your Todo",
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
                    title(),
                    const SizedBox(
                      height: 20,
                    ),
                    label("Task Type"),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        taskType("Important", 0xffcb1104),
                        const SizedBox(
                          width: 15,
                        ),
                        taskType("Planned", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    label("Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    description(),
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
                        taskCategory("Food", 0xffff6d6e),
                        const SizedBox(
                          width: 15,
                        ),
                        taskCategory("Workout", 0xfff29732),
                        const SizedBox(
                          width: 15,
                        ),
                        taskCategory("Work", 0xff6557ff),
                        const SizedBox(
                          width: 15,
                        ),
                        taskCategory("Miscellaneous", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    edit! ? button() : Container(),
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
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance
            .collection("Tasks")
            .doc(widget.docId)
            .update({
          "title": _titleController!.text.trim(),
          "description": _descController!.text.trim(),
          "task-type": type,
          "category": category,
        });
        Navigator.pop(context);
      },
      child: Container(
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
            "Edit Done ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget taskType(String label, int color) {
    return InkWell(
      onTap: edit!
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: type == label
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.blue, width: 2))
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget taskCategory(String label, int color) {
    return InkWell(
      onTap: edit!
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: type == label
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(144))
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
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

  Widget title() {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 46, 62),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Enter task title",
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 3),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 46, 62),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _descController,
        enabled: edit,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Enter task description",
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 3),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
