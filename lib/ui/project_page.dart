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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(projectContent.description, style: TextStyle(
              fontSize: 20,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(
                  label: Row(children: <Widget>[Text('SSH Connection '
                      'Success'), Icon(Icons.check)
                  ],),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                ),
                Chip(
                  label: Row(children: <Widget>[Text('Git '
                      'Success'), Icon(Icons.check)
                  ],),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                ),
                Chip(
                  label: Row(children: <Widget>[Text('SSH Connection '
                      'Success'), Icon(Icons.check)
                  ],),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                )
              ],
            ),
            Divider(),
            //TODO: Use datatable widget to show files
            Text('this is where the files should look'),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(projectContent.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}