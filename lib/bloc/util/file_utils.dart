import 'dart:io';

List<File> searchFilesAndPattern(Directory dir, String fileName, String pattern) {
  return dir.listSync(recursive: true)
    .whereType<File>()
    .where((file) => file.uri.pathSegments.last == fileName)
    .where((file) => file.readAsStringSync().contains(pattern))
    .toList();
}
