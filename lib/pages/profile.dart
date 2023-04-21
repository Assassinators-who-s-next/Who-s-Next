import 'package:basic_auth/components/profile_picture.dart';
import 'package:basic_auth/components/profile_text_field.dart';
import 'package:basic_auth/models/user_data.dart';
import 'package:basic_auth/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.user;

    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Profile Page', style: TextStyle(fontSize: 50)),
            ),
            buildPicture(user, context),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 100),
              child: Column(
                children: [
                  buildDisplayedInfo(user),
                ],
              ),
            ),
        ],
    ));
  }

  Padding buildPicture(UserData user, BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
            children: [
              ProfilePicture(
                  radius: 250,
                  imagePath: user.imagePath ?? UserPreferences.placeholderImage,
                  onClicked: () => print("Profile picture clicked"),
                  ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
          );
  }

  Widget buildDisplayedInfo(UserData userData) => Column(
    children: [
      ProfileTextField(
        label: "Name", 
        text: userData.name, 
        onChanged: (name) {},
        ),
    ],
  );
}
