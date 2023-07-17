// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:github_search/view_model/search_provider.dart';
import 'search_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchNotifier>()])
void main() {
  late SearchNotifier searchNotifier;
  setUp(() {
    searchNotifier = MockSearchNotifier();
  });

  test('SearchNotifierクラスのUnitテスト', () async {
    when(searchNotifier.searchQuery('UnitTest', '1'))
        .thenAnswer((_) => Future.value('success'));
    when(searchNotifier.searchQuery('UnitTest2', '2'))
        .thenAnswer((_) => Future.value('unexpected error'));

    // テスト
    final successResponse = await searchNotifier.searchQuery('UnitTest', '1');
    final errorResponse = await searchNotifier.searchQuery('UnitTest2', '2');

    // 処理が何回呼び出されたか
    verify(searchNotifier.searchQuery('UnitTest', '1')).called(1);
    verify(searchNotifier.searchQuery('UnitTest2', '2')).called(1);

    // 期待通りの結果が返ってきているか
    expect(successResponse, equals('success'));
    expect(errorResponse, equals('unexpected error'));
  });
}
