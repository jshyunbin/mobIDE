import 'package:flutter/material.dart';
import 'package:mobide/ui/project_page.dart';
import 'package:mobide/ui/theme/style.dart';
import 'package:flutter/cupertino.dart';

class _ProjectDescription extends StatelessWidget {
  _ProjectDescription({
    Key key,
    this.projectContent,
  }) : super(key: key);

  final ProjectContent projectContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${projectContent.title}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '${projectContent.description}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                (projectContent.sshId == null)
                    ? 'local'
                    : '${projectContent.sshId}',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${projectContent.initializedDate} · ${projectContent.modifiedDate} ★',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectListItem extends StatelessWidget {
  ProjectListItem({
    Key key,
    this.projectContent,
  }) : super(key: key);

  final ProjectContent projectContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        child: Ink(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
            child: _ProjectDescription(
              projectContent: projectContent,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProjectPage(
                      projectContent: projectContent,
                    )),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key, this.toDestination}) : super(key: key);

  final Object toDestination;

  ProjectContent projectContent = ProjectContent(
    title: 'sample 0',
    description: 'Lorem ipsum dolor '
        'sit amet, consectetur adipiscing elit.',
    sshId: 'jhb-gram',
    initializedDate: '2019-12-24',
    modifiedDate: '2019-12-24',
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 125.0,
          backgroundColor: Colors.white,
          pinned: true,
          floating: true,
          snap: true,
          title: Padding(
            padding: EdgeInsets.all(10),
            child: Text('Projects', style: Type.header4.apply(color: Colors
                .black),),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: <Widget>[
                SizedBox(height: 90.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                  child: Container(
                    height: 36.0,
                    width: double.infinity,
                    child: CupertinoTextField(
                      keyboardType: TextInputType.text,
                      placeholder: 'Search for projects',
                      placeholderStyle: Type.subtitle1.apply(color: Color
                        (0xffC4C6CC),),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Column(crossAxisAlignment:
                CrossAxisAlignment.start, children: <Widget>[ProjectListItem
                (projectContent: projectContent,), Divider()],),
            childCount: 7,
          ),
        )
      ],
    );
//    return ListView.separated(
//      itemCount: 5,
//      itemBuilder: (context, index) {
//        return ProjectListItem(
//          projectContent: projectContent,
//        );
//      },
//      separatorBuilder: (context, index) => Divider(),
//    );
  }
}
