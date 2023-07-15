import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo_model.freezed.dart';
part 'github_repo_model.g.dart';

@freezed
// github検索結果を格納するモデル
class GithubRepoModel with _$GithubRepoModel {
  factory GithubRepoModel({
    required String name,
    required String ownerIcon,
    required String language,
    required int star,
    required int watcher,
    required int fork,
    required int issue,
  }) = _GithubRepoModel;

  factory GithubRepoModel.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoModelFromJson(json);
}
