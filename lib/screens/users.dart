import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/models/user.dart';
import 'package:queen_of_peace/providers/user_provider.dart';
import 'package:queen_of_peace/widgets/add_user.dart';
import 'package:queen_of_peace/widgets/edit_user.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    List<User> users = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return ListTile(
              title: Text(user.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(user.email)],
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return EditUser(provider.updateUser, user);
                            });
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            );
          }),
      /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddUser(provider.addUser);
                });
          },
        )*/
    );
  }
}
