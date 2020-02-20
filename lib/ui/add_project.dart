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
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'Project Title',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'Project Description',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'SSH host',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'SSH port',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'SSH username',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'SSH password',
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: 'Project Path',
                            ),
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
