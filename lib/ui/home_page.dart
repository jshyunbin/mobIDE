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
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobide/backend/sql_handler.dart';
import 'package:mobide/ui/add_project.dart';
import 'package:mobide/ui/project_page.dart';
import 'package:mobide/ui/theme/style.dart';

class ProjectListItem extends StatelessWidget {
  ProjectListItem({
    Key key,
    this.projectContent,
  }) : super(key: key);

  final ProjectContent projectContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(projectContent.title, style: Type.header5),
                      SizedBox(height: 15),
                      Text(projectContent.description, style: Type.body1)
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: SizedBox(height: 10)),
                  ),
                  Expanded(
                    flex: 17,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: SizedBox(height: 10)),
                  ),
                  Expanded(
                    flex: 5,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: SizedBox(height: 10)),
                  ),
                  Expanded(
                    flex: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                        ),
                        child: SizedBox(height: 10)),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Text(projectContent.modifiedDate, style: Type.body2),
                      SizedBox(height: 5),
                      Text(projectContent.sshId, style: Type.body2),
                    ],
                  ))
            ],
          )),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProjectPage(
                projectContent: projectContent,
              )),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHandler dbHandler = DatabaseHandler();
  List projects = [];

  void loadData() async {
    projects = await dbHandler.getData(DBType.project);
    setState(() {});
  }

  ProjectContent projectContent(int i) {
    Project project = projects[i];
    Map data = project.toMap();
    return ProjectContent(
      title: data['name'],
      description: data['description'],
      sshId: data['sshName'],
      initializedDate: data['initDate'],
      modifiedDate: data['modDate'],
    );
  }

  void searchChanged(String str) {
    setState(() {
      //TODO: change list content when searched
    });
  }

  void _addPressed(context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => AddProject());
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return SafeArea(
        bottom: false,
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 125.0,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                snap: true,
                title: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Projects',
                    style: Type.header4.apply(color: Colors.black),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () => _addPressed(context),
                  ),
                  SizedBox(width: 10),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: <Widget>[
                      SizedBox(height: 60.0),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                        child: Container(
                          height: 36.0,
                          width: double.infinity,
                          child: CupertinoTextField(
                            keyboardType: TextInputType.text,
                            placeholder: 'Search for projects',
                            placeholderStyle: Type.subtitle1.apply(
                              color: Color(0xffC4C6CC),
                            ),
                            prefix: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                              child: Icon(
                                Icons.search,
                                color: Color(0xffC4C6CC),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color(0xffF0F1F5),
                            ),
                            onChanged: searchChanged,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(15),
                sliver: SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  itemCount: projects.length,
                  itemBuilder: (context, index) => new ProjectListItem(
                    projectContent: projectContent(index),
                  ),
                  staggeredTileBuilder: (index) => new StaggeredTile.fit(
                      (MediaQuery.of(context).size.width > 600) ? 2 : 4),
                ),
              ),
            ],
          ),
        ));
  }

}
