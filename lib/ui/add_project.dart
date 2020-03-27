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
                          FlatButton(child: Text('Cancel', style: Type.body1
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
