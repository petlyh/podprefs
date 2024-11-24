import "package:shared_preferences/shared_preferences.dart";

typedef SPrefs = SharedPreferencesWithCache;

/// Determines how values of type [T] will be stored and retrieved from shared preferences.
class PrefStorer<T> {
  PrefStorer.asBool({
    required T? Function(bool encoded) decode,
    required bool Function(T value) encode,
  })  : _read = ((key, prefs) => prefs.getBool(key).map(decode)),
        _write = ((key, prefs, value) => prefs.setBool(key, encode(value)));

  PrefStorer.asDouble({
    required T? Function(double encoded) decode,
    required double Function(T value) encode,
  })  : _read = ((key, prefs) => prefs.getDouble(key).map(decode)),
        _write = ((key, prefs, value) => prefs.setDouble(key, encode(value)));

  PrefStorer.asInt({
    required T? Function(int encoded) decode,
    required int Function(T value) encode,
  })  : _read = ((key, prefs) => prefs.getInt(key).map(decode)),
        _write = ((key, prefs, value) => prefs.setInt(key, encode(value)));

  PrefStorer.asString({
    required T? Function(String encoded) decode,
    required String Function(T value) encode,
  })  : _read = ((key, prefs) => prefs.getString(key).map(decode)),
        _write = ((key, prefs, value) => prefs.setString(key, encode(value)));

  PrefStorer.asStringList({
    required T? Function(List<String> encoded) decode,
    required List<String> Function(T value) encode,
  })  : _read = ((key, prefs) => prefs.getStringList(key).map(decode)),
        _write =
            ((key, prefs, value) => prefs.setStringList(key, encode(value)));

  PrefStorer.asStringMapped(Map<T, String> map)
      : this.asString(
          decode: (value) => map.entries
              .where((entry) => entry.value == value)
              .firstOrNull
              ?.key,
          encode: (key) => map[key] ?? "",
        );

  static final string = PrefStorer.asString(decode: _f, encode: _f);
  static final stringList = PrefStorer.asStringList(decode: _f, encode: _f);
  static final numDouble = PrefStorer.asDouble(decode: _f, encode: _f);
  static final numInt = PrefStorer.asInt(decode: _f, encode: _f);
  static final boolean = PrefStorer.asBool(decode: _f, encode: _f);

  final T? Function(String key, SPrefs prefs) _read;
  final Future<void> Function(String key, SPrefs prefs, T value) _write;

  T? read(String key, SPrefs prefs) => _read(key, prefs);

  Future<void> write(String key, SPrefs prefs, T value) async =>
      await _write(key, prefs, value);
}

/// Helper function that returns the input unchanged.
T _f<T>(T v) => v;

extension _MapNullable<T> on T? {
  U? map<U>(U? Function(T) f) => this != null ? f(this as T) : null;
}
