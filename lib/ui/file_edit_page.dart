import 'package:flutter/material.dart';
import 'package:mobide/ui/theme/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FileEditPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  BorderRadiusGeometry panelRadius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SlidingUpPanel(
        backdropEnabled: true,
        borderRadius: panelRadius,
        controller: _pc,
        minHeight: 0,
        panel: Center(child: Text('Terminal')),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              snap: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'test.cpp',
                style: Type.header4.apply(color: Colors.black),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                )),
                IconButton(
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  onPressed: _pc.open,
                ),
                IconButton(
                    icon: Icon(
                  Icons.call_received,
                  color: Colors.blue,
                )),
                IconButton(
                    icon: Icon(
                  Icons.call_made,
                  color: Colors.blue,
                )),
                IconButton(
                    icon: Icon(
                  Icons.call_split,
                  color: Colors.blue,
                )),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'sample0',
                          style: Type.body1,
                        ),
                        Icon(Icons.chevron_right),
                        Text(
                          'test.cpp',
                          style: Type.body1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return DecoratedBox(
                    child: Text('This is the edit Text property.'),
                    decoration: BoxDecoration(color: Colors.amber),
                  );
                },
                childCount: 100,
              ),
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.black12),
                child: Text(
                  'Drawer Header',
                  style: Type.header5,
                )),
            ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Git: master'),
            ),
            Divider(),
            ListTile(
              title: Text('Current Tabs'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('test.cpp'),
              trailing: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('test2.cpp'),
              trailing: Icon(
                Icons.close,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
