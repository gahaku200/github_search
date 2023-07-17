// Project imports:
import 'package:github_search/model/github_repo_model.dart';

// テスト用検索結果の共通データ
class GithubRepoData {
  static final List<GithubRepoModel> repos = [
    GithubRepoModel(
      name: 'flutter',
      ownerIcon: 'https://avatars.githubusercontent.com/u/14101776?v=4',
      language: 'dart',
      star: 2,
      watcher: 4,
      fork: 3,
      issue: 2,
    ),
    GithubRepoModel(
      name: 'flutter repo',
      ownerIcon: 'https://avatars.githubusercontent.com/u/14101776?v=4',
      language: 'php',
      star: 2,
      watcher: 2,
      fork: 3,
      issue: 4,
    ),
    GithubRepoModel(
      name: 'flutter portfolio',
      ownerIcon: 'https://avatars.githubusercontent.com/u/12619420?v=4',
      language: 'ruby',
      star: 2,
      watcher: 7,
      fork: 2,
      issue: 8,
    ),
  ];
}
