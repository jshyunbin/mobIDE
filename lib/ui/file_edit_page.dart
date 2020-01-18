import 'package:flutter/material.dart';
import 'package:mobide/ui/terminal.dart';
import 'package:mobide/ui/theme/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FileEditPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final BorderRadiusGeometry panelRadius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  final PanelController _pc = new PanelController();

  Widget _panel() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  'Terminal',
                  style: Type.header4.apply(color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: TerminalPage(),
          ),
        ],
      ),
    );
  }

  Widget _body(context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 90.0,
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
                    height: 60,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SlidingUpPanel(
        backdropEnabled: true,
        borderRadius: panelRadius,
        controller: _pc,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        panel: _panel(),
        body: _body(context),
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
            ListTile(
              leading: Icon(Icons.call_received),
              title: Text('Git pull'),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text('Git commit'),
            ),
            ListTile(
              leading: Icon(Icons.call_made),
              title: Text('Git push'),
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
