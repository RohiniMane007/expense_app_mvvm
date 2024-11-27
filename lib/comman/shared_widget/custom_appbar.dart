import 'package:expense_app/core/utils/custom_textstyle.dart';
import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String initial;
  final List<Widget> actions;

  // Constructor
  const CustomAppBar({
    super.key,
    required this.title,
    required this.initial,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context);
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

    return AppBar(
      title: Text(
        title,
        style:
            CustomTextStyle.titleTextStyle(fontsize: 22, color: Colors.white),
      ),
      centerTitle: true, // Optional, for centering the title
      backgroundColor:
          Colors.teal, // You can change this to any color or gradient
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
              child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Container(
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    await storage.deleteAll();
                                    if (!context.mounted) return;
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Logout")),
                            ],
                          ),
                        ))
                      ])),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard height for AppBar
}
