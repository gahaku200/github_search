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
import 'package:github_search/view/search.dart';
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
          name: 'Search',
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
              name: 'Search',
            ),
        );
        await screenMatchesGolden(
          tester,
          'searchAfter',
        );
      });
    });
  });
}
