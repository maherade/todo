import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/settings/theme_bottomsheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Mode',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              setState(() {
                showThemeBottomSheet();
              });
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: settingsProvider.isDarkMood()
                      ? MyTheme.itemDarkColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingsProvider.isDarkMood() ? 'Dark' : 'Light',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }
}
