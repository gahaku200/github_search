// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:run_with_network_images/run_with_network_images.dart';

// Project imports:
import 'package:github_search/const/theme_data.dart';
import 'package:github_search/view/search.dart';
import 'package:github_search/view_model/dark_theme_provider.dart';
import 'package:github_search/view_model/search_provider.dart';
import '../common_data/github_repo_data.dart';

void main() {
  group('Search画面のゴールデンテスト', () {
    testGoldens('検索前のゴールデンテスト', (WidgetTester tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: ProviderScope(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Murecho',
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ja', ''),
              ],
              home: const Search(),
            ),
          ),
          name: 'SearchBefore',
        );
      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'searchBefore');
    });
    testGoldens('検索後のゴールデンテスト', (WidgetTester tester) async {
      await runWithNetworkImages(() async {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: ProviderScope(
                // GithubRepoData.reposのデータを追加する
                overrides: [
                  searchProvider.overrideWith(
                    (ref) {
                      return SearchNotifier()
                        ..updateForTest(GithubRepoData.repos);
                    },
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: 'Murecho',
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('ja', ''),
                  ],
                  home: const Search(),
                ),
              ),
              name: 'SearchAfter',
            ),
        );
        await screenMatchesGolden(
          tester,
          'searchAfter',
        );
      });
    });
    testGoldens('検索前のdarkモードゴールデンテスト', (WidgetTester tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              themeState.overrideWith(
                (ref) {
                  return DarkThemeProvider()..isDarkTheme = true;
                },
              ),
            ],
            child: Consumer(
              builder: (BuildContext context, ref, child) {
                return FutureBuilder(
                  future: ref.watch(themeState.notifier).initialState(),
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: Styles.themeData(true, context),
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('ja', ''),
                      ],
                      home: const Search(),
                    );
                  },
                );
              },
            ),
          ),
          name: 'searchBeforeDarkmode',
        );
      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'searchBeforeDarkmode');
    });
    testGoldens('検索後のdarkモードゴールデンテスト', (WidgetTester tester) async {
      await runWithNetworkImages(() async {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: ProviderScope(
                // GithubRepoData.reposのデータを追加する
                overrides: [
                  themeState.overrideWith(
                    (ref) {
                      return DarkThemeProvider()..isDarkTheme = true;
                    },
                  ),
                  searchProvider.overrideWith(
                    (ref) {
                      return SearchNotifier()
                        ..updateForTest(GithubRepoData.repos);
                    },
                  ),
                ],
                child: Consumer(
                  builder: (BuildContext context, ref, child) {
                    return FutureBuilder(
                      future: ref.watch(themeState.notifier).initialState(),
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: Styles.themeData(true, context),
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          supportedLocales: const [
                            Locale('ja', ''),
                          ],
                          home: const Search(),
                        );
                      },
                    );
                  },
                ),
              ),
              name: 'SearchAfterDarkmode',
            ),
        );
        await screenMatchesGolden(
          tester,
          'searchAfterDarkmode',
        );
      });
    });
  });
}
