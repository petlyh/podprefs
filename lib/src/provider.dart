import "package:podprefs/src/controller.dart";
import "package:podprefs/src/storer.dart";
import "package:riverpod/riverpod.dart";

/// Type signature for preference providers.
typedef Preference<T> = NotifierProvider<PreferenceController<T>, T>;

/// Creates a preference provider with a custom [PrefStorer].
Preference<T> createPreference<T>(
  String key,
  T defaultValue,
  PrefStorer<T> storer,
) =>
    NotifierProvider<PreferenceController<T>, T>(
      () => PreferenceController(
        key: key,
        defaultValue: defaultValue,
        storer: storer,
      ),
    );

/// Creates a preference provider for a [String].
Preference<String> createStringPreference(
  String key, [
  String defaultValue = "",
]) =>
    createPreference(key, defaultValue, PrefStorer.string);

/// Creates a preference provider for a [double].
Preference<double> createDoublePreference(
  String key, [
  double defaultValue = 0.0,
]) =>
    createPreference(key, defaultValue, PrefStorer.numDouble);

/// Creates a preference provider for a [int].
Preference<int> createIntPreference(String key, [int defaultValue = 0]) =>
    createPreference(key, defaultValue, PrefStorer.numInt);

/// Creates a preference provider for a [bool].
Preference<bool> createBoolPreference(
  String key, [
  bool defaultValue = false,
]) =>
    createPreference(key, defaultValue, PrefStorer.boolean);

/// Creates a preference provider for a string [List].
Preference<List<String>> createStringListPreference(
  String key, [
  List<String> defaultValue = const [],
]) =>
    createPreference(key, defaultValue, PrefStorer.stringList);

/// Creates a preference provider with a mapping between [T] values and its string representations.
Preference<T> createMappedPreference<T>(
  String key,
  T defaultValue,
  Map<T, String> valueMap,
) =>
    createPreference(key, defaultValue, PrefStorer.asStringMapped(valueMap));
