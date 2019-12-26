import 'package:flutter/material.dart';

class ProjectContent {

  ProjectContent({this.title, this.description, this.sshId, this
      .initializedDate, this.modifiedDate}) : super();

  String title;
  String description;
  String sshId;
  String initializedDate;
  String modifiedDate;
}

class ProjectPage extends StatelessWidget {

  const ProjectPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text('Project Page');
  }
}