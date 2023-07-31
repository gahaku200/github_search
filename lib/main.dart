// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'const/loading.dart';
import 'const/theme_data.dart';
import 'view/search.dart';
import 'view_model/dark_theme_provider.dart';
import 'view_model/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DIの設定
  GetIt.I.registerLazySingleton<http.Client>(
    http.Client.new,
  );
  GetIt.I.registerLazySingleton<SearchNotifier>(
    SearchNotifier.new,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) {
      runApp(
        ProviderScope(
          child: Consumer(
            builder: (BuildContext context, ref, child) {
              final value = ref.watch(themeState);
              return FutureBuilder(
                future: ref.watch(themeState.notifier).initialState(),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  return snapshot.hasData
                      ? MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: Styles.themeData(value, context),
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          supportedLocales: const [
                            Locale('ja', ''),
                            Locale('en', ''),
                          ],
                          home: const Search(),
                        )
                      : const LoadingView();
                },
              );
            },
          ),
        ),
      );
    },
  );
}
