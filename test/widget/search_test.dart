// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:run_with_network_images/run_with_network_images.dart';

// Project imports:
import 'package:github_search/view/search.dart';
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

        expect(find.text('github検索画面'), findsOneWidget);
        expect(find.text('githubリポジトリ名を入力'), findsOneWidget);
        expect(find.text('検索'), findsOneWidget);
        expect(find.text('検索結果なし'), findsOneWidget);

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
  });
}
