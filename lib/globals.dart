library whos_next.globals;

import 'models/user_data.dart';
import 'models/match_options.dart';
import 'game_group.dart';

UserData myUserData = UserData(
  uid: "",
  imagePath: "",
  name: "",
  email: "",
  pronouns: "",
  description: "",
  frequentedLocations: "",
);
String myName = "no_name";
group selectedGroup = group(
    "no",
    [],
    MatchOptions(
      100,
      'Single',
      'Fixed',
      5,
      'Limited',
      60,
      'Area A',
      'Helmet',
    ));
List<group> myGroups = [];
