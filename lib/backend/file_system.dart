import 'package:path_provider/path_provider.dart';
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

    await _client.disconnect();

    return res;
  }

  Future<void> download(_File file) async {
    final dir = await getApplicationDocumentsDirectory();

    await _client.connectSFTP();
    await _client.sftpDownload(
        path: '${file.path}/${file.name}', toPath: '$dir${file.path}');
    await _client.disconnectSFTP();
  }

  Future<void> cancelDownload() async {
    await _client.sftpCancelDownload();
  }

  Future<void> upload(_File file) async {
    final dir = await getApplicationDocumentsDirectory();

    await _client.connectSFTP();
    await _client.sftpUpload(
        path: '$dir${file.path}/${file.name}', toPath: '${file.path}');
    await _client.disconnectSFTP();
  }

  Future<void> cancelUpload() async {
    await _client.sftpCancelUpload();
  }
}
