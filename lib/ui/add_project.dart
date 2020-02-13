import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/ui/theme/style.dart';

class AddProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              20,
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(child: Text('Cancle', style: Type.body1
                              .apply(color: Colors.blue),),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Add Project',
                            style: Type.header5,
                          ),
                          FlatButton(
                            child: Text(
                              'Add',
                              style: Type.body1.apply(color: Colors.blue),
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                      Divider(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.black38, width: 1),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Project Title'),
                            ),
                            ListTile(
                              title: Text('Project Description'),
                            ),
                            ListTile(
                              title: Text('SSH Server'),
                            ),
                            ListTile(
                              title: Text('path to project'),
                            ),
                            ListTile(
                              title: Text('etc... fill this out later...'),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
          )
      ),
    );
  }
}
