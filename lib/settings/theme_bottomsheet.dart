import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';

import '../my_theme/my_theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 150.0),
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: settingsProvider.isDarkMood()
                  ? MyTheme.lightPrimary
                  : Colors.grey[400],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              settingsProvider.changeTheme(ThemeMode.light);
            },
            child: settingsProvider.isDarkMood()
                ? getUnSelectedItem('Light')
                : getSelectedItem('Light'),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              settingsProvider.changeTheme(ThemeMode.dark);
            },
            child: settingsProvider.isDarkMood()
                ? getSelectedItem('Dark')
                : getUnSelectedItem('Dark'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        const Icon(
          Icons.check,
          size: 30,
        )
      ],
    );
  }

  Widget getUnSelectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
