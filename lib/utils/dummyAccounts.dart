import 'package:lite_chat/shared/profileAvatar.dart';

class DummyAccounts {
  ProfileAvatar profileAvatar = ProfileAvatar();
  String username;
  String msgs;
  String time;
  bool seen;
  bool isSent;
  DummyAccounts({
    required this.profileAvatar,
    required this.msgs,
    required this.time,
    required this.username,
    this.seen = true,
    this.isSent = false,
  });
}
