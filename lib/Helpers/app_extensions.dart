

import 'package:flutter/foundation.dart';

extension NullableStringExtensions on String? {

  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullNotEmpty {
    return this != null && this!.isNotEmpty;
  }

  String get capitalizeFirst {
    if (isNullOrEmpty) return "";
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  bool get containsOnlyLetters {
    return this?.contains(RegExp(r'^[a-zA-Z]+$')) ?? false;
  }

  /// convert to integer
  int get toInt => toInteger();

  /// convert to double
  double get toFloat => toDouble();

  int toInteger({int defaultVal = 0}) {
    try {
      if (isNullOrEmpty) {
        return defaultVal;
      }
      return int.tryParse(this!) ?? defaultVal;
    } catch (e, stackTrace) {
      debugPrint("Error converting '$this' to int. Returning default value: $defaultVal");
      debugPrint("$stackTrace");
      return defaultVal;
    }
  }

  double toDouble({double defaultVal = 0.0}) {
    try {
      if (isNullOrEmpty) {
        return defaultVal;
      }
      return double.tryParse(this!) ?? defaultVal;
    } catch (e, stackTrace) {
      debugPrint("Error converting '$this' to double. Returning default value: $defaultVal");
      debugPrint("$stackTrace");
      return defaultVal;
    }
  }

  String get truncate {
    if(this == null) return "";
    if(this!.isEmpty || this!.length < 32) {
      return this!;
    }
    return "${this!.substring(0, 10)}...${this!.substring(this!.length - 10)}";
  }

}


extension ListExtension<T> on List<T>? {
  /// Check both not null and not empty.
  bool get listIsNotNullAndNotEmpty => this != null && this!.isNotEmpty;
  bool get listIsNullOREmpty => this == null || this!.isEmpty;
  List toLowerCase() {
    return this?.map((e) => e.toString().toLowerCase()).toList() ?? [];
  }
  T? containsAny(List<T> elements) {
    if(listIsNullOREmpty) return null;
    for (T element in elements) {
      if (this!.toLowerCase().contains(element.toString().toLowerCase())) {
        return element;
      }
    }
    return null;
  }
  /// • if list isEmpty will add & return 1 <br>
  /// • else if isNotEmpty will try to update the element on the provided condition & return 0 <br>
  /// • else list isNotEmpty and condition not satisfied then simply add in list & return -1.
  int updateOrAppend(bool Function(T) predicate, T newElement) {
    if(listIsNullOREmpty) {
      this!.add(newElement);
      return 1;
    }
    for (int i = 0; i < this!.length; i++) {
      if (predicate(this![i])) {
        this![i] = newElement;
        return 0;
      }
    }
    this!.add(newElement);
    return -1;
  }

  /// just update the list with newElement where condition is true OR
  /// return the value at index using atIndex callback
  void updateWhere(bool Function(T,) predicate, T? newElement, {T Function(int i)? atIndex}) {
    if(listIsNullOREmpty) return;
    for (int i = 0; i < this!.length; i++) {
      if (predicate(this![i],)) {
        this![i] = newElement ?? (atIndex != null ? atIndex(i) : this![i]);
        return;
      }
    }
  }

  T? get firstOrNull {
    if(listIsNullOREmpty) return null;
    return this!.first;
  }

  T? get lastOrNull {
    if(listIsNullOREmpty) return null;
    return this!.last;
  }

  /// Finds the first element that satisfies the given predicate [test].
  /// If no element satisfies the predicate, it returns the result of [orElse].
  dynamic findWhere(bool Function(T element) test, {required Function() orElse,}) {
    for (var element in this ?? []) {
      if (test(element)) {
        return element;
      }
    }
    return orElse();
  }
}

extension NormalizeToStringExtension on dynamic {
  /// if obj type is `List<String>` then return comma-separated String `"str1,str2"`,
  /// else return obj.toString()
  String get normalizeToString {
    try {
      if (this == null) return "";

      if (this is List<String>) {
        return (this as List<String>).join(',');
      } else if (this is String) {
        return this as String;
      } else {
        return toString();
      }
    } catch (e, stackTrace) {
      debugPrint('Error normalizing to string: $e');
      debugPrint(stackTrace.toString());
      return '';
    }
  }
}