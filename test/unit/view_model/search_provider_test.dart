// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:github_search/view_model/search_provider.dart';
import 'search_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>(), MockSpec<SearchNotifier>()])
void main() {
  test('MockSearchNotifierクラスのUnitテスト成功例', () async {
    // Mock作成
    final client = MockClient();

    // 成功するパターンを設定
    when(
      client.get(
        Uri.https(
          'api.github.com',
          '/search/repositories',
          {
            'q': 'MockTestSuccess',
            'per_page': '30',
            'page': '1',
          },
        ),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"items": [{"name": "flutter", "owner": {"avatar_url": "https://avatars.githubusercontent.com/u/14101776?v=4"}, "language": "dart", "star": 2, "watcher": 4, "fork": 3, "issue": 2}]}',
        200,
      ),
    );

    // 失敗するパターンを設定
    when(
      client.get(
        Uri.https(
          'api.github.com',
          '/search/repositories',
          {
            'q': 'MockTestFailed',
            'per_page': '30',
            'page': '1',
          },
        ),
      ),
    ).thenThrow(Exception('Unexpected exception'));

    // DIの設定
    GetIt.I.registerLazySingleton<http.Client>(() => client);

    // SearchNotifierをモックを使用してテスト
    final notifier = SearchNotifier();
    // 成功パターンのテスト
    final successResult = await notifier.searchQuery('MockTestSuccess', '1');
    expect(successResult, 'success');
    // 失敗パターンのテスト
    final failedResult = await notifier.searchQuery('MockTestFailed', '1');
    expect(failedResult, 'Exception: Unexpected exception');

    // 処理が何回呼び出されたか
    verify(notifier.searchQuery('MockTestSuccess', '1')).called(1);
    verify(notifier.searchQuery('MockTestFailed', '1')).called(1);
  });
}
