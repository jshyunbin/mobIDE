//Copyright 2020 Joshua Hyunbin Lee, Jaeyong Sung
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/ui/theme/style.dart';

class SettingsComponent {
  SettingsComponent(this.icon, this.title, this.sideWidget);

  final Icon icon;
  final String title;
  final Widget sideWidget;
}

class SettingsPage extends StatefulWidget {
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
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => Navigator.pop(context)),
                title: Text(settingsComponents[_selectedIndex].title),
              ),
              body: settingsComponents[_selectedIndex].sideWidget,
            ),
          ),
        );
      }
    });
  }

  void _searchChanged(String str) {
    setState(() {
      //TODO: change list when searched
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
                  child: CupertinoScrollbar(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 125.0,
                          backgroundColor: Colors.white,
                          pinned: true,
                          floating: true,
                          snap: true,
                          title: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Settings',
                              style: Type.header4.apply(color: Colors.black),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Column(
                              children: <Widget>[
                                SizedBox(height: 90.0),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 6.0, 16.0, 16.0),
                                  child: Container(
                                    height: 36.0,
                                    width: double.infinity,
                                    child: CupertinoTextField(
                                      keyboardType: TextInputType.text,
                                      placeholder: 'Search for settings',
                                      placeholderStyle: Type.subtitle1.apply(
                                        color: Color(0xffC4C6CC),
                                      ),
                                      prefix: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            9.0, 6.0, 9.0, 6.0),
                                        child: Icon(
                                          Icons.search,
                                          color: Color(0xffC4C6CC),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        color: Color(0xffF0F1F5),
                                      ),
                                      onChanged: _searchChanged,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) => Column(
                              children: <Widget>[
                                ListTile(
                                  leading: settingsComponents[index].icon,
                                  title: Text(settingsComponents[index].title,
                                      style: Type.body1),
                                  onTap: () => onItemTap(index, true),
                                ),
                                Divider()
                              ],
                            ),
                            childCount: settingsComponents.length,
                          ),
                        )
                      ],
                    ),
                  )),
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
          return SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 125.0,
                  backgroundColor: Colors.white,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Settings',
                      style: Type.header4.apply(color: Colors.black),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: <Widget>[
                        SizedBox(height: 60.0),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                          child: Container(
                            height: 36.0,
                            width: double.infinity,
                            child: CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'Search for settings',
                              placeholderStyle: Type.subtitle1.apply(
                                color: Color(0xffC4C6CC),
                              ),
                              prefix: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    9.0, 6.0, 9.0, 6.0),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xffC4C6CC),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Color(0xffF0F1F5),
                              ),
                              onChanged: _searchChanged,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: settingsComponents[index].icon,
                          title: Text(settingsComponents[index].title,
                              style: Type.body1),
                          onTap: () => onItemTap(index, false),
                        ),
                        Divider()
                      ],
                    ),
                    childCount: settingsComponents.length,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
