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
import 'package:github_search/view/search_detail.dart';
import 'package:github_search/view_model/dark_theme_provider.dart';
import 'package:github_search/view_model/search_provider.dart';
import '../common_data/github_repo_data.dart';

void main() {
  group('Search詳細画面のゴールデンテスト', () {
    testGoldens('Lightモードのゴールデンテスト', (WidgetTester tester) async {
      await runWithNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
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
        );

        // BuildContextを取得
        final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Search),
        );
        // ProviderContainerを取得
        final container = ProviderScope.containerOf(context);
        // ProviderContainerからsearchProviderをreadしてstateを更新
        container
            .read(searchProvider.notifier)
            .updateForTest(GithubRepoData.repos);

        // state更新後再描画
        await tester.pump();

        // ListTileをタップし、再描画（詳細画面が表示される）
        await tester.tap(find.byType(ListTile).first);
        await tester.pump();

        // find.byType()を使ってSearchウィジェットを特定
        final searchWidgetFinder = find.byType(SearchDetail);

        // tester.widget()を使ってSearchウィジェットを取得
        final searchWidget = tester.widget(searchWidgetFinder) as SearchDetail;

        await tester.pumpDeviceBuilder(
          DeviceBuilder()
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
                  home: searchWidget,
                ),
              ),
              name: 'SearchDetailLightmode',
            ),
        );
        await screenMatchesGolden(
          tester,
          'searchDetailLightmode',
        );
      });
    });
    testGoldens('darkモードのゴールデンテスト', (WidgetTester tester) async {
      await runWithNetworkImages(() async {
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('ja', ''),
              ],
              home: Search(),
            ),
          ),
        );

        // BuildContextを取得
        final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Search),
        );
        // ProviderContainerを取得
        final container = ProviderScope.containerOf(context);
        // ProviderContainerからsearchProviderをreadしてstateを更新
        container
            .read(searchProvider.notifier)
            .updateForTest(GithubRepoData.repos);

        // state更新後再描画
        await tester.pump();

        // ListTileをタップし、再描画（詳細画面が表示される）
        await tester.tap(find.byType(ListTile).first);
        await tester.pump();

        // find.byType()を使ってSearchウィジェットを特定
        final searchWidgetFinder = find.byType(SearchDetail);

        // tester.widget()を使ってSearchウィジェットを取得
        final searchWidget = tester.widget(searchWidgetFinder) as SearchDetail;

        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: ProviderScope(
                overrides: [
                  themeState.overrideWith(
                    (ref) {
                      return DarkThemeProvider()..isDarkTheme = true;
                    },
                  ),
                ],
                child: MaterialApp(
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
                  home: searchWidget,
                ),
              ),
              name: 'SearchDetailDarkmode',
            ),
        );
        await screenMatchesGolden(
          tester,
          'searchDetailDarkmode',
        );
      });
    });
  });
}
