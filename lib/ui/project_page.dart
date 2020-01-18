import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/ui/file_edit_page.dart';
import 'package:mobide/ui/theme/style.dart';

class ProjectContent {
  ProjectContent({this.title,
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

  //TODO: make processCard an independent class
  Widget processCard(String title) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.black54,
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Type.header5.apply(color: Colors.white),
                ),
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
                SizedBox(width: 10.0),
                Text('Connected',
                    style: Type.header6.apply(color: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          title: Text(
            projectContent.title,
            style: Type.header4.apply(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                projectContent.description,
                style: Type.body1,
              ),
              SizedBox(
                height: 20.0,
              ),
              LayoutBuilder(
                builder: (context, constraint) {
                  if (constraint.maxWidth > 600) {
                    return Row(
                      children: <Widget>[
                        Expanded(child: processCard('SSH')),
                        SizedBox(width: 20.0),
                        Expanded(child: processCard('Git')),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        processCard('SSH'),
                        SizedBox(height: 20.0),
                        processCard('Git'),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ));
  }

  Widget _temp(context) {
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
                          builder: (context) => FileEditPage(),
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
