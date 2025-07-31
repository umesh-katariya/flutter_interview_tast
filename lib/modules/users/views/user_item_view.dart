import 'package:flutter/material.dart';
import 'package:flutter_interview_tast/data/models/user_model.dart';

class UserItemView extends StatelessWidget {
  final UserModel user;
  final Function()? onTap;
  const UserItemView({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Text(user.city),
      onTap: onTap,
    );
  }
}
