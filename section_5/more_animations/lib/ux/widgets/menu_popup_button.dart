import 'package:animated_list/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MenuCommands {
  darkModeSwitch,
  settings,
}

class MenuPopupButton extends StatelessWidget {
  const MenuPopupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (_, themeModel, child) {
        return PopupMenuButton<MenuCommands>(
          onSelected: (result) {
            switch (result) {
              case MenuCommands.darkModeSwitch:
                themeModel.changeDarkModeSetting();
                break;
              default:
                break;
            }
          },
          offset: const Offset(0, 48),
          itemBuilder: (context) => <PopupMenuEntry<MenuCommands>>[
            CheckedPopupMenuItem<MenuCommands>(
              checked: themeModel.darkMode,
              value: MenuCommands.darkModeSwitch,
              child: const Text('Dark Mode'),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<MenuCommands>(
              value: MenuCommands.settings,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          ],
        );
      },
    );
  }
}
