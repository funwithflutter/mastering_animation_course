import 'package:animated_list/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MenuCommands {
  darkModeSwitch,
  settings,
}

class MenuPopupButton extends StatelessWidget {
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
                print(result);
                break;
            }
          },
          offset: Offset(0, 48),
          itemBuilder: (context) => <PopupMenuEntry<MenuCommands>>[
            CheckedPopupMenuItem<MenuCommands>(
              checked: themeModel.darkMode,
              value: MenuCommands.darkModeSwitch,
              child: Text('Dark Mode'),
            ),
            PopupMenuDivider(),
            PopupMenuItem<MenuCommands>(
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
