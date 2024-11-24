import "package:podprefs/src/storage.dart";
import "package:podprefs/src/storer.dart";
import "package:riverpod/riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

/// A controller for a single preference of type [T].
class PreferenceController<T> extends Notifier<T> {
  /// Creates a controller that manages a single preference.
  PreferenceController({
    required this.key,
    required this.defaultValue,
    required this.storer,
  });

  /// The key used to store and retrieve the preference value with Shared Preferences.
  final String key;
  final T defaultValue;
  final PrefStorer<T> storer;

  @override
  T build() => storer.read(key, _getStorage()) ?? defaultValue;

  /// Updates the preference value and writes it to storage.
  Future<void> update(T value) async {
    await storer.write(key, _getStorage(), value);
    state = value;
  }

  /// Resets preference to the default value.x
  Future<void> reset() async => await update(defaultValue);

  /// Whether the the preference's value differs from the default value.
  bool get isChanged => state != defaultValue;

  SharedPreferencesWithCache _getStorage() =>
      ref.read(sharedPreferencesProvider);
}
