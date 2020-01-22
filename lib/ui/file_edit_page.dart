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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'test.cpp',
          style: Type.header4.apply(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.attach_money, color: Colors.green),
            onPressed: _pc.open,
          ),
        ],
      ),
      body: SizedBox(
          height: 1000,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(child: Text('editor property')),
          )),
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
    );
  }
}
