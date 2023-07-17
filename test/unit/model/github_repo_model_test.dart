// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:github_search/model/github_repo_model.dart';

void main() {
  test('GithubRepoModelクラスのUnitテスト', () {
    final result = GithubRepoModel(
      name: 'flutter',
      ownerIcon: 'https://avatars.githubusercontent.com/u/14101776?v=4',
      language: 'dart',
      star: 2,
      watcher: 4,
      fork: 3,
      issue: 2,
    );

    expect(result.name, 'flutter');
    expect(
      result.ownerIcon,
      'https://avatars.githubusercontent.com/u/14101776?v=4',
    );
    expect(result.language, 'dart');
    expect(result.star, 2);
    expect(result.watcher, 4);
    expect(result.fork, 3);
    expect(result.issue, 2);
  });
}
