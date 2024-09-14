import 'dart:convert';

import 'package:mit_ocw/features/course/domain/library.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserDataKeys {
  library
}

class UserDataRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<Library> getLibrary() async {
    String? librarySerialized = await prefs.getString(UserDataKeys.library.name);

    if (librarySerialized == null) {
      return Library(courses: []);
    }

    print("Got library serialized: $librarySerialized");
    Library library = Library.fromJson(jsonDecode(librarySerialized));
    print("Retrieved library: ${library.toJson()}");
    return library;
  }

  Future<bool> addToLibrary(String coursenum) async {
    Library library = await getLibrary();
    if (!library.courses.contains(coursenum)) {
      library.courses.add(coursenum);
      await prefs.setString(UserDataKeys.library.name, jsonEncode(library.toJson()));

      print("Added to library: $coursenum");
      print("Current library: ${library.toJson()}");

      return true;
    }

    return false;
  }

  Future<void> removeFromLibrary(String coursenum) async {
    Library library = await getLibrary();
    library.courses.remove(coursenum);
    await prefs.setString(UserDataKeys.library.name, jsonEncode(library.toJson()));

    print("Removed from library: $coursenum");
    print("Current library: ${library.toJson()}");
  }

  Future<bool> isInLibrary(String coursenum) async {
    Library library = await getLibrary();
    return library.courses.contains(coursenum);
  }
}

