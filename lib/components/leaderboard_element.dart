import 'package:whos_next/player.dart';
import 'package:whos_next/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'profile_picture.dart';

class LeaderboardElement extends StatelessWidget {
  final Player player;
  final String playerName;
  final int playerPoints;
  final bool eliminated;

  const LeaderboardElement(
      {super.key,
      required this.player,
      required this.playerName,
      required this.playerPoints,
      required this.eliminated});

  String getName() {
    return playerName;
  }

  String getPoints() {
    return '$playerPoints';
  }

  @override
  Widget build(BuildContext context) {
    String playerImagePath = UserPreferences.placeholderImagePath;
    bool isNetworkPath = false;
    if (player.userData?.imagePath != null &&
        player.userData!.imagePath != "") {
      playerImagePath = player.userData!.imagePath!;
      isNetworkPath = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfilePicture(
          radius: 50,
          imagePath: playerImagePath,
          isNetworkPath: isNetworkPath,
          onClicked: () {},
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            playerName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          playerPoints.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
