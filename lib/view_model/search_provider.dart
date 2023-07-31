// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../model/github_repo_model.dart';

class SearchNotifier extends StateNotifier<List<GithubRepoModel>> {
  SearchNotifier() : super([]);

  // githubリポジトリ検索処理
  Future<String> searchQuery(
    String searchText,
    String page,
  ) async {
    final client = GetIt.I<http.Client>();
    try {
      // 検索ボタンを押下した場合はまずstateを空にする
      if (page == '1') {
        state = [];
      }
      // GitHub APIに通信する
      await client
          .get(
        Uri.https(
          'api.github.com',
          '/search/repositories',
          {
            'q': searchText,
            'per_page': '30',
            'page': page,
          },
        ),
      )
          .then(
        (response) async {
          // GitHub API通信の結果を受け、stateに格納する
          final result = jsonDecode(response.body);
          final items = result['items'] as List<dynamic>;
          final updatedList = items
              .map(
                (repository) => GithubRepoModel(
                  name: repository['name'] as String? ?? '',
                  ownerIcon: repository['owner']['avatar_url'] as String? ?? '',
                  language: repository['language'] as String? ?? '',
                  star: repository['stargazers_count'] as int? ?? 0,
                  watcher: repository['watchers_count'] as int? ?? 0,
                  fork: repository['forks_count'] as int? ?? 0,
                  issue: repository['open_issues_count'] as int? ?? 0,
                ),
              )
              .toList();
          state = [...state, ...updatedList];
        },
      );
      return 'success';
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      return error.toString();
    }
  }

  // テスト用、検索結果をstateに追加する
  void updateForTest(List<GithubRepoModel> updatedList) {
    state = [...state, ...updatedList];
  }
}

// SearchNotifierクラスのprovider
final searchProvider =
    StateNotifierProvider<SearchNotifier, List<GithubRepoModel>>(
  (ref) => SearchNotifier(),
);
