import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: _size.height / 2.5,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image(
                      image: AssetImage("assets/images/default-avatar.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black38,
                          Colors.transparent,
                          Colors.black38,
                        ],
                        stops: [0.1, 0.5, 0.9],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // build details section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  radius: 5,
                  center: Alignment.topCenter,
                ),
              ),
              child: buildProfileDetails(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileDetails(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: buildDetailedFields(context, "Name", "Abhijith")),
              Container(
                height: 40,
                width: 1,
                color: Color(0xFF707070),
              ),
              GestureDetector(
                onTap: () => print("like"),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.red,
                        ),
                        SizedBox(height: 5),
                        Text("200K"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: buildDetailedFields(
                context, "About", "Everything happens for a cause ✨"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDetailedFields(context, "Phone", "9876543210"),
                SizedBox(width: 15),
                buildDetailedFields(
                    context, "E - Mail", "abhijithak683@gmail.com"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: buildDetailedFields(context, "Place", "Kannur"),
          ),
        ],
      );

  Widget buildDetailedFields(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18)),
        SizedBox(height: 5),
        Text(value, style: Theme.of(context).textTheme.subtitle1!.copyWith()),
      ],
    );
  }
}
