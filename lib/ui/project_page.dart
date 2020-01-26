import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/backend/file_system.dart';
import 'package:mobide/ui/text_editor.dart';

class ProjectContent {
  ProjectContent(
      {this.title,
      this.description,
      this.sshId,
      this.initializedDate,
      this.modifiedDate})
      : super();

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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              projectContent.description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(
                  label: Row(
                    children: <Widget>[
                      Text('SSH Connection '
                          'Success'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                ),
                Chip(
                  label: Row(
                    children: <Widget>[
                      Text('Git '
                          'Success'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                ),
                Chip(
                  label: Row(
                    children: <Widget>[
                      Text('SSH Connection '
                          'Success'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Color.fromARGB(100, 52, 235, 100),
                )
              ],
            ),
            Divider(),
            //TODO: Use datatable widget to show files
            Text('this is where the files should look'),
            DataTable(
              columns: [
                DataColumn(label: Icon(Icons.check_box_outline_blank)),
                DataColumn(label: Text('File')),
                DataColumn(label: Text('Status'))
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Icon(Icons.code)),
                  DataCell(Text('test.cpp'), onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              TextEditor.fromFile(
                                  file: SSHFile(
                                      'hello.txt', FileType.txt, 'a', 'a',
                                      'a')),
                        ));
                  }),
                  DataCell(Icon(Icons.check)),
                ]),
              ],
            ),
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
