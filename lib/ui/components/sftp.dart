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

class SFTPPage extends StatefulWidget {
  @override
  _SFTPPageState createState() => _SFTPPageState();
}

class _SFTPPageState extends State<SFTPPage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0))),
      child: Center(
        child: Text('SFTP Here'),
      ),
    );
  }
}
