
import 'package:flutter/material.dart';

class _ProjectDescription extends StatelessWidget {
  _ProjectDescription({
    Key key,
    this.title,
    this.description,
    this.sshId,
    this.initializedDate,
    this.modifiedDate,
  }) : super(key: key);

  final String title;
  final String description;
  final String sshId;
  final String initializedDate;
  final String modifiedDate;

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
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$description',
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
                (sshId == null)? 'local' : '$sshId',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$initializedDate · $modifiedDate ★',
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
    this.title,
    this.description,
    this.sshId,
    this.initializedDate,
    this.modifiedDate,
    this.callBack
  }) : super(key: key);

  final String title;
  final String description;
  final String sshId;
  final String initializedDate;
  final String modifiedDate;
  final Object callBack;

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
              title: title,
              description: description,
              sshId: sshId,
              initializedDate: initializedDate,
              modifiedDate: modifiedDate,
            ),
          ),
        ),
        onTap: callBack,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key, this.toDestination}): super(key: key);

  final Object toDestination;


  @override
  Widget build(BuildContext context) {
    return ListView(
      //TODO: replace the list.
      children: <Widget>[
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',
          callBack: toDestination,),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
        ProjectListItem(title: 'sample 0', description: 'Lorem ipsum dolor '
            'sit amet, consectetur adipiscing elit.', sshId: null,
          initializedDate: '2019-12-24', modifiedDate: '2019-12-24',),
      ],
    );
  }
}