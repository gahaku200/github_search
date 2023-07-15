// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GithubRepoModel _$GithubRepoModelFromJson(Map<String, dynamic> json) {
  return _GithubRepoModel.fromJson(json);
}

/// @nodoc
mixin _$GithubRepoModel {
  String get name => throw _privateConstructorUsedError;
  String get ownerIcon => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  int get star => throw _privateConstructorUsedError;
  int get watcher => throw _privateConstructorUsedError;
  int get fork => throw _privateConstructorUsedError;
  int get issue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GithubRepoModelCopyWith<GithubRepoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoModelCopyWith<$Res> {
  factory $GithubRepoModelCopyWith(
          GithubRepoModel value, $Res Function(GithubRepoModel) then) =
      _$GithubRepoModelCopyWithImpl<$Res, GithubRepoModel>;
  @useResult
  $Res call(
      {String name,
      String ownerIcon,
      String language,
      int star,
      int watcher,
      int fork,
      int issue});
}

/// @nodoc
class _$GithubRepoModelCopyWithImpl<$Res, $Val extends GithubRepoModel>
    implements $GithubRepoModelCopyWith<$Res> {
  _$GithubRepoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ownerIcon = null,
    Object? language = null,
    Object? star = null,
    Object? watcher = null,
    Object? fork = null,
    Object? issue = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerIcon: null == ownerIcon
          ? _value.ownerIcon
          : ownerIcon // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      watcher: null == watcher
          ? _value.watcher
          : watcher // ignore: cast_nullable_to_non_nullable
              as int,
      fork: null == fork
          ? _value.fork
          : fork // ignore: cast_nullable_to_non_nullable
              as int,
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GithubRepoModelCopyWith<$Res>
    implements $GithubRepoModelCopyWith<$Res> {
  factory _$$_GithubRepoModelCopyWith(
          _$_GithubRepoModel value, $Res Function(_$_GithubRepoModel) then) =
      __$$_GithubRepoModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String ownerIcon,
      String language,
      int star,
      int watcher,
      int fork,
      int issue});
}

/// @nodoc
class __$$_GithubRepoModelCopyWithImpl<$Res>
    extends _$GithubRepoModelCopyWithImpl<$Res, _$_GithubRepoModel>
    implements _$$_GithubRepoModelCopyWith<$Res> {
  __$$_GithubRepoModelCopyWithImpl(
      _$_GithubRepoModel _value, $Res Function(_$_GithubRepoModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ownerIcon = null,
    Object? language = null,
    Object? star = null,
    Object? watcher = null,
    Object? fork = null,
    Object? issue = null,
  }) {
    return _then(_$_GithubRepoModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerIcon: null == ownerIcon
          ? _value.ownerIcon
          : ownerIcon // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      watcher: null == watcher
          ? _value.watcher
          : watcher // ignore: cast_nullable_to_non_nullable
              as int,
      fork: null == fork
          ? _value.fork
          : fork // ignore: cast_nullable_to_non_nullable
              as int,
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GithubRepoModel implements _GithubRepoModel {
  _$_GithubRepoModel(
      {required this.name,
      required this.ownerIcon,
      required this.language,
      required this.star,
      required this.watcher,
      required this.fork,
      required this.issue});

  factory _$_GithubRepoModel.fromJson(Map<String, dynamic> json) =>
      _$$_GithubRepoModelFromJson(json);

  @override
  final String name;
  @override
  final String ownerIcon;
  @override
  final String language;
  @override
  final int star;
  @override
  final int watcher;
  @override
  final int fork;
  @override
  final int issue;

  @override
  String toString() {
    return 'GithubRepoModel(name: $name, ownerIcon: $ownerIcon, language: $language, star: $star, watcher: $watcher, fork: $fork, issue: $issue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GithubRepoModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerIcon, ownerIcon) ||
                other.ownerIcon == ownerIcon) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.watcher, watcher) || other.watcher == watcher) &&
            (identical(other.fork, fork) || other.fork == fork) &&
            (identical(other.issue, issue) || other.issue == issue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, ownerIcon, language, star, watcher, fork, issue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GithubRepoModelCopyWith<_$_GithubRepoModel> get copyWith =>
      __$$_GithubRepoModelCopyWithImpl<_$_GithubRepoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GithubRepoModelToJson(
      this,
    );
  }
}

abstract class _GithubRepoModel implements GithubRepoModel {
  factory _GithubRepoModel(
      {required final String name,
      required final String ownerIcon,
      required final String language,
      required final int star,
      required final int watcher,
      required final int fork,
      required final int issue}) = _$_GithubRepoModel;

  factory _GithubRepoModel.fromJson(Map<String, dynamic> json) =
      _$_GithubRepoModel.fromJson;

  @override
  String get name;
  @override
  String get ownerIcon;
  @override
  String get language;
  @override
  int get star;
  @override
  int get watcher;
  @override
  int get fork;
  @override
  int get issue;
  @override
  @JsonKey(ignore: true)
  _$$_GithubRepoModelCopyWith<_$_GithubRepoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
