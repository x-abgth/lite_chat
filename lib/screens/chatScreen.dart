import 'package:flutter/material.dart';
import 'package:lite_chat/shared/profileAvatar.dart';
import 'package:lite_chat/utils/colors.dart';
import 'package:lite_chat/utils/msgBubble.dart';

class ChatScreen extends StatelessWidget {
  List<MsgBubble> _demoChats = [
    MsgBubble(msg: "Hi", time: "4:50 PM"),
    MsgBubble(msg: "Hi 👋", isPrimary: false, time: "4:56 PM"),
    MsgBubble(msg: "How Are you?", time: "4:58 PM"),
    MsgBubble(msg: "I'm fine, How Are you?", isPrimary: false, time: "5:02 PM"),
    MsgBubble(msg: "Me too 🥰", time: "5:05 PM"),
    MsgBubble(msg: "Eda", time: "5:05 PM"),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileAvatar(
                height: 40,
                width: 40,
                pad: 0,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("aishu__"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Online",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF434343),
                Color(0xFF000000),
              ],
              radius: 5,
              center: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _demoChats.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: _demoChats[index].isPrimary
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      _demoChats[index],
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  height: 50,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [kPrimaryColor, kSecondaryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add, color: Colors.white60)),
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Type something",
                            hintStyle: TextStyle(color: Colors.white24),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white10, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white10, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.send, color: Colors.white60)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
