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
  group('search詳細画面Widgetテスト', () {
    testWidgets('詳細画面のWidgetテスト', (WidgetTester tester) async {
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

        expect(find.text('検索詳細'), findsOneWidget);
        expect(find.text('flutter'), findsNWidgets(2));
        expect(find.text('開発言語：dart'), findsOneWidget);
        expect(find.text('2'), findsNWidgets(5));
        expect(find.text('4'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);

        expect(find.byIcon(Icons.close), findsNWidgets(2));
        expect(find.byIcon(Icons.star_border), findsNWidgets(4));
        expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
        expect(find.byIcon(Icons.fork_right_outlined), findsOneWidget);
        expect(find.byIcon(Icons.bug_report_outlined), findsOneWidget);
      });
    });
  });
}
