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
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ssh/ssh.dart';

enum FileType { dir, bin, txt, unknown, etc }

class SSHFile {
  String name;
  FileType type;
  String path;
  String sshHost, sshId;

  SSHFile(this.name, this.type, this.path, this.sshHost, this.sshId);

  Future<String> read() async {
//    var dir = await getApplicationDocumentsDirectory();
//    var filePath = p.join(dir.path, sshHost, sshId, path, name);
//    print(filePath);
//    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
//      throw 'File Not Found!';
//    }
//    return File(filePath).readAsStringSync();
    return "Hello, World";
  }

  Future<void> write(String contents) async {
    var dir = await getApplicationDocumentsDirectory();
    var filePath = p.join(dir.path, sshHost, sshId, path, name);
    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
      throw 'File Not Found!';
    }
    File(filePath).writeAsStringSync(contents);
  }
}

class FileSystem {
  final SSHClient _client;

  FileSystem({
    @required String host,
    @required int port,
    @required String username,
    @required dynamic passwordOrKey,
  }) : _client = SSHClient(
      host: host,
      port: port,
      username: username,
      passwordOrKey: passwordOrKey);

  Future<List<SSHFile>> getFiles([String path = '.']) async {
    await _client.connect();

    var s = '';
    await _client.execute('ls -a $path').then((v) {
      s = v;
    });
    var l = s.split('\n').where((a) => a != '.' && a != '..' && a != '');
    List<SSHFile> res = [];

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
        res.add(SSHFile(i, FileType.dir, s, _client.host, _client.id));
      } else if (fileType.contains('text')) {
        res.add(SSHFile(i, FileType.txt, s, _client.host, _client.id));
      } else {
        res.add(SSHFile(i, FileType.bin, s, _client.host, _client.id));
      }
    }

    await _client.disconnect();

    return res;
  }

  Future<void> download(SSHFile file, {Function callback}) async {
    if (file.type == FileType.dir) return;
    final dir = await getApplicationDocumentsDirectory();

    await _client.connectSFTP();
    await _client.sftpDownload(
        path: p.join(file.path, file.name),
        toPath: p.join(dir.path, file.sshHost, file.sshId, file.path),
        callback: callback);
    await _client.disconnectSFTP();
  }

  Future<void> cancelDownload() async {
    await _client.sftpCancelDownload();
  }

  Future<void> upload(SSHFile file, {Function callback}) async {
    final dir = await getApplicationDocumentsDirectory();

    await _client.connectSFTP();

    if (file.type == FileType.dir) {
      await _client.sftpMkdir(file.path);
    } else {
      await _client.sftpUpload(
          path:
          p.join(dir.path, file.sshHost, file.sshId, file.path, file.name),
          toPath: file.path,
          callback: callback);
    }
    await _client.disconnectSFTP();
  }

  Future<void> cancelUpload() async {
    await _client.sftpCancelUpload();
  }
}
