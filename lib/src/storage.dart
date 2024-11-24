import "package:riverpod/riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Creates an override for [sharedPreferencesProvider] with an initialized [SharedPreferencesWithCache] instance.
Future<Override> initializePreferences() async =>
    sharedPreferencesProvider.overrideWithValue(
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      ),
    );

/// Provider for the [SharedPreferencesWithCache] instance used by Podprefs.
///
/// Must be overridden before usage, which can be done with [initializePreferences] .
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>(
  (_) => throw Exception("Shared Preferences not initialized"),
);
