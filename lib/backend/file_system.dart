import 'package:ssh/ssh.dart';

enum FileType { dir, bin, txt, unknown, etc }

class _File {
  String name;
  FileType type;
  String path;

  _File(this.name, this.type, this.path);
}

class FileSystem {
  SSHClient _client;

  FileSystem(this._client);

  void connect() async {}

  Future<List<_File>> getFiles([String path = '.']) async {
    await _client.connect();
    var s = '';
    await _client.execute('ls -a $path').then((v) {
      s = v;
    });
    var l = s.split('\n').where((a) => a != '.' && a != '..' && a != '');
    List<_File> res = [];

    for (var i in l) {
      var fileType = '';
      await _client
          .execute('file -b --mime-type $path/$i | sed \'s|/.*||\'')
          .then((v) {
        fileType = v;
      });
      await _client.execute('pwd').then((v) {
        s = v;
      });
      if (fileType.contains('inode')) {
        res.add(_File(i, FileType.dir, s));
      } else if (fileType.contains('text')) {
        res.add(_File(i, FileType.txt, s));
      } else {
        res.add(_File(i, FileType.bin, s));
      }
    }

    print('-----------------------');

    return res;
  }
}
