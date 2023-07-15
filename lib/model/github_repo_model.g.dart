// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepoModel _$$_GithubRepoModelFromJson(Map<String, dynamic> json) =>
    _$_GithubRepoModel(
      name: json['name'] as String,
      ownerIcon: json['ownerIcon'] as String,
      language: json['language'] as String,
      star: json['star'] as int,
      watcher: json['watcher'] as int,
      fork: json['fork'] as int,
      issue: json['issue'] as int,
    );

Map<String, dynamic> _$$_GithubRepoModelToJson(_$_GithubRepoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ownerIcon': instance.ownerIcon,
      'language': instance.language,
      'star': instance.star,
      'watcher': instance.watcher,
      'fork': instance.fork,
      'issue': instance.issue,
    };
