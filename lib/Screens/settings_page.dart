import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              value: const Text('English'),
            ),
          ],
        ),
        SettingsSection(title: const Text('Appearance'), tiles: <SettingsTile>[
          SettingsTile.navigation(
              leading: const Icon(Icons.format_paint),
              title: const Text('Appearance'),
              value: Text(
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? "Light"
                      : "Dark")),
        ])
      ],
    );
  }
}
