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

  int _selectedIndex = 0;

  //TODO: replace Text() widgets to side Widgets
  static List<SettingsComponent> settingsComponents = [
    SettingsComponent(Icon(Icons.edit), 'Editor', Text('Editor')),
    SettingsComponent(Icon(Icons.account_circle), 'Account', Text('Account')),
    SettingsComponent(Icon(Icons.timeline), 'Version Control', Text('Version '
        'Control')),
    SettingsComponent(Icon(Icons.vpn_key), 'SSH Configurations', Text('SSH')),
    SettingsComponent(Icon(Icons.fingerprint), 'Password', Text('Password')),
    SettingsComponent(Icon(Icons.build), 'Build and Execution', Text('Build')),
    SettingsComponent(Icon(Icons.bug_report), 'Bug Report', Text('Bug')),
    SettingsComponent(Icon(Icons.info), 'Information', Text('Info')),
  ];

  void onItemTap(int index, bool largeScreen) {
    setState(() {
      _selectedIndex = index;
      if (!largeScreen) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () => Navigator.pop(context)
            ),
            title: Text(settingsComponents[_selectedIndex].title),
            ),
          body: settingsComponents[_selectedIndex].sideWidget,
          ),
        ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: settingsComponents[index].icon,
                        title: Text(settingsComponents[index].title),
                        onTap: () => onItemTap(index, true),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: settingsComponents.length
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: settingsComponents[_selectedIndex].sideWidget,
                ),
              ),
            ],
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            itemCount: settingsComponents.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: settingsComponents[index].icon,
                  title: Text(settingsComponents[index].title),
                  onTap: () => onItemTap(index, false),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        }
      },
    );
  }
}