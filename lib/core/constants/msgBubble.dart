import 'package:flutter/material.dart';
import 'package:lite_chat/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MsgBubble extends StatelessWidget {
  final String msg;
  final String time;
  final bool isPrimary;
  MsgBubble({this.msg = "", this.isPrimary = true, required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: isPrimary
                ? [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.tertiary
                  ]
                : [Color(0xFF1e272c), Color(0xFF1a2228)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Column(
        crossAxisAlignment:
            isPrimary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment:
                isPrimary ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
              SizedBox(width: 5),
              isPrimary
                  ? Icon(FontAwesomeIcons.solidCheckCircle,
                      size: 12, color: Colors.grey[500])
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
