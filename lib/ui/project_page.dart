import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/ui/file_edit_page.dart';
import 'package:mobide/ui/theme/style.dart';

import 'components/process_card.dart';

class ProjectContent {
  ProjectContent(
      {this.title,
      this.description,
      this.sshId,
      this.initializedDate,
      this.modifiedDate})
      : super();

  String title;
  String description;
  String sshId;
  String initializedDate;
  String modifiedDate;
}

class ProjectPage extends StatelessWidget {
  ProjectPage({Key key, this.projectContent}) : super(key: key);

  final ProjectContent projectContent;

  Widget _file(String name, Function onTap) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.code),
                SizedBox(width: 10.0),
                Text(name, style: Type.header6.apply(color: Colors.white)),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, color: Colors.white),
          ],
        ),
      ),
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            projectContent.title,
            style: Type.header4.apply(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(projectContent.description, style: Type.body1),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 2.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return (index == 2)
                        ? addProcessCard()
                        : ProcessCard('ssh', null, true);
                  },
                  childCount: 3,
                ),
              ),
            ),

            // Files
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Files', style: Type.header5),
                      FlatButton(
                          onPressed: null,
                          child: Row(
                            children: <Widget>[
                              Text('Sort By Type'),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ))
                    ],
                  ),
                  DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Column(
                          children: <Widget>[
                            _file('test.cpp', () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => FileEditPage(),
                                  ));
                            }),
                            Divider(
                              color: Colors.black87,
                            ),
                            _file('test.cpp', () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => FileEditPage(),
                                  ));
                            }),
                            Divider(
                              color: Colors.black87,
                            ),
                            _file('test.cpp', () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => FileEditPage(),
                                  ));
                            }),
                            Divider(
                              color: Colors.black87,
                            ),
                            _file('test.cpp', () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => FileEditPage(),
                                  ));
                            }),
                          ],
                        ),
                      ))
                ]),
              ),
            ),
          ],
        )
    );
  }
}
