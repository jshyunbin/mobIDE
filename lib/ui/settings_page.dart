import 'package:flutter/material.dart';

class SettingsComponent{
  SettingsComponent(this.icon, this.title, this.sideWidget);

  final Icon icon;
  final String title;
  final Widget sideWidget;
}

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  int selectedIndex = 0;

  static List<SettingsComponent> settingsComponents = [
    SettingsComponent(Icon(Icons.settings), 'General Settings', null),
    SettingsComponent(Icon(Icons.account_circle), 'Account', null),
    SettingsComponent(Icon(Icons.fingerprint), 'Password', null),
    SettingsComponent(Icon(Icons.bug_report), 'Bug Report', null),
    SettingsComponent(Icon(Icons.info), 'Information', null),
  ];

  static List<Widget> settingsWidget = [
    ListView(
      children: <Widget>[
        Text('General Settings'),

      ],
    )
  ];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Row(
            children: <Widget>[
              settingsWidget.elementAt(selectedIndex),
            ],
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            itemCount: settingsComponents.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: settingsComponents[index].icon,
                  title: Text(settingsComponents[index].title)
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        }
      },
    );
  }
}