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

  const ProjectPage({Key key, this.projectContent}) : super(key: key);

  final ProjectContent projectContent;

  @override
  Widget build(BuildContext context) {
    //TODO: add project page
    return Scaffold(
      body: Row(
        children: <Widget>[
          Text(projectContent.title),

        ],
      ),
      appBar: AppBar(
        leading: Icon(Icons.keyboard_arrow_left),
        title: Text(projectContent.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: null,
      ),
    );
  }
}