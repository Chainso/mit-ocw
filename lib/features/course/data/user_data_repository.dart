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

    Library library = Library.fromJson(jsonDecode(librarySerialized));
    print("Retrieved library: ${library.toJson()}");
    return library;
  }

  Future<bool> addToLibrary(int courseId) async {
    Library library = await getLibrary();
    if (!library.courses.contains(courseId)) {
      library.courses.add(courseId);
      await prefs.setString(UserDataKeys.library.name, jsonEncode(library.toJson()));

      print("Added to library: $courseId");
      print("Current library: ${library.toJson()}");

      return true;
    }

    return false;
  }

  Future<void> removeFromLibrary(int courseId) async {
    Library library = await getLibrary();
    library.courses.remove(courseId);
    await prefs.setString(UserDataKeys.library.name, jsonEncode(library.toJson()));

    print("Removed from library: $courseId");
    print("Current library: ${library.toJson()}");
  }

  Future<bool> isInLibrary(int courseId) async {
    Library library = await getLibrary();
    return library.courses.contains(courseId);
  }
}

