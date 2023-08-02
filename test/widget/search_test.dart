// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:run_with_network_images/run_with_network_images.dart';

// Project imports:
import 'package:github_search/const/theme_data.dart';
import 'package:github_search/view/search.dart';
import 'package:github_search/view_model/dark_theme_provider.dart';
import 'package:github_search/view_model/search_provider.dart';
import '../common_data/github_repo_data.dart';

void main() {
  group('search画面Widgetテスト', () {
    testWidgets('検索前後のWidgetテスト', (WidgetTester tester) async {
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
        // テキストテスト
        expect(find.text('github検索画面'), findsOneWidget);
        expect(find.text('githubリポジトリ名を入力'), findsOneWidget);
        expect(find.text('検索'), findsOneWidget);
        expect(find.text('検索結果なし'), findsOneWidget);
        // アイコンテスト
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

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

        expect(find.text('検索結果なし'), findsNothing);
        expect(find.text('flutter'), findsOneWidget);
        expect(find.text('flutter repo'), findsOneWidget);
        expect(find.text('flutter portfolio'), findsOneWidget);
        expect(find.text('2'), findsNWidgets(3));

        expect(find.byType(ListTile), findsNWidgets(3));
        expect(find.byIcon(Icons.star_border), findsNWidgets(3));
      });
    });
    testWidgets('Themeスイッチのテスト', (WidgetTester tester) async {
      await runWithNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            child: Consumer(
              builder: (BuildContext context, ref, child) {
                final value = ref.watch(themeState);
                return FutureBuilder(
                  future: ref.watch(themeState.notifier).initialState(),
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    return MaterialApp(
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
                      ],
                      home: const Search(),
                    );
                  },
                );
              },
            ),
          ),
        );
      });

      // Drawerをタップし、再描画
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // widgetテスト
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsNothing);
      expect(find.text('Light mode'), findsOneWidget);
      expect(find.text('Dark mode'), findsNothing);

      // MaterialApp widgetを探して、その背景色を取得する
      var materialApp =
          find.byType(MaterialApp).evaluate().first.widget as MaterialApp;
      var backgroundColor = materialApp.theme?.scaffoldBackgroundColor;
      // 初期状態ではライトモードになっていることを確認する
      expect(backgroundColor, equals(lightThemeData.scaffoldBackgroundColor));

      // SwitchListTileをタップする
      await tester.tap(find.byType(SwitchListTile));
      // ダークモードに更新されるため再描画が必要
      await tester.pumpAndSettle();

      // widgetテスト
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.byIcon(Icons.light_mode_outlined), findsNothing);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
      expect(find.text('Light mode'), findsNothing);
      expect(find.text('Dark mode'), findsOneWidget);

      // 再度MaterialApp widgetを探して、その背景色を取得する
      materialApp =
          find.byType(MaterialApp).evaluate().first.widget as MaterialApp;
      backgroundColor = materialApp.theme?.scaffoldBackgroundColor;
      // ダークモードになっていることを確認する
      expect(backgroundColor, equals(darkThemeData.scaffoldBackgroundColor));

      // SwitchListTileをタップする
      await tester.tap(find.byType(SwitchListTile));
      // アイコンが更新されるため再描画が必要
      await tester.pumpAndSettle();

      // アイコンが更新され、アイコンはライトモードが表示されることを確認する
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsNothing);

      // 再度MaterialApp widgetを探して、その背景色を取得する
      materialApp =
          find.byType(MaterialApp).evaluate().first.widget as MaterialApp;
      backgroundColor = materialApp.theme?.scaffoldBackgroundColor;
      // ライトモードになっていることを確認する
      expect(backgroundColor, equals(lightThemeData.scaffoldBackgroundColor));
    });
  });
}

// ライトモードのプロパティ
final lightThemeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: const Color(0xFFE8FDFD),
        brightness: Brightness.light,
      ),
  cardColor: const Color(0xFFF2FDFD),
  canvasColor: Colors.grey[50],
);

// ダークモードのプロパティ
final darkThemeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF00001a),
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: const Color(0xFF1a1f3c),
        brightness: Brightness.dark,
      ),
  cardColor: const Color(0xFF0a0d2c),
  canvasColor: Colors.black.withOpacity(0.85),
);
