import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final dynamic func;
  final double height;
  final double width;
  final bool isOnline;
  final double pad;
  final AssetImage? img;
  ProfileAvatar(
      {this.func,
      this.height = 40,
      this.width = 40,
      this.isOnline = false,
      this.pad = 10,
      this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(left: pad),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: img ?? AssetImage("assets/default-avatar.jpg"),
                )),
          ),
          Positioned(
            bottom: 0.5,
            right: 2,
            child: isOnline
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
