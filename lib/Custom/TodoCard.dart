import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
      {Key? key,
      this.title,
      this.iconData,
      this.iconColor,
      this.time,
      this.check,
      this.iconBgColor,
      this.onChange,
      this.index,
      this.userid})
      : super(key: key);
  final String? title;
  final IconData? iconData;
  final Color? iconColor;
  final String? time;
  final bool? check;
  final Color? iconBgColor;
  final String? userid;
  final Function? onChange;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
              data: ThemeData(
                  primarySwatch: Colors.blue,
                  unselectedWidgetColor: const Color.fromRGBO(43, 46, 61, 1)),
              child: Expanded(
                child: Container(
                  height: 75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: const Color.fromRGBO(43, 46, 61, 0.819),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 33,
                          width: 36,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(iconData, color: iconColor),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(title!,
                              style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        Text(time!,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
