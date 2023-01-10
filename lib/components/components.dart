import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';

ShowLoading(BuildContext context, String message) {
  var settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: settingsProvider.isDarkMood()
                ? MyTheme.darkPrimary
                : Colors.white,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: settingsProvider.isDarkMood()
                            ? Colors.white
                            : Colors.blue),
                  )
                ],
              ),
            ),
          ));
}

hideLaoding(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(
    BuildContext context, String message, String posBtn, VoidCallback posAction,
    {String? negBtn, VoidCallback? negAction}) {
  var settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) {
      List<Widget> Action = [
        TextButton(
          onPressed: posAction,
          child: Text(
            posBtn,
            style: TextStyle(
                color:
                    settingsProvider.isDarkMood() ? Colors.white : Colors.blue),
          ),
        ),
      ];
      if (negBtn != null) {
        Action.add(
          TextButton(
            onPressed: negAction,
            child: Text(
              negBtn,
              style: TextStyle(
                  color: settingsProvider.isDarkMood()
                      ? Colors.white
                      : Colors.blue),
            ),
          ),
        );
      }
      return AlertDialog(
        backgroundColor:
            settingsProvider.isDarkMood() ? MyTheme.darkPrimary : Colors.white,
        title: Text(
          message,
          style: TextStyle(
              color:
                  settingsProvider.isDarkMood() ? Colors.white : Colors.blue),
        ),
        actions: Action,
      );
    },
  );
}
