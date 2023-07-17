// Mocks generated by Mockito 5.4.2 from annotations
// in github_search/test/unit/view_model/search_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Dart imports:
import 'dart:async' as _i4;

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i6;

// Project imports:
import 'package:github_search/model/github_repo_model.dart' as _i5;
import 'package:github_search/view_model/search_provider.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SearchNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchNotifier extends _i1.Mock implements _i2.SearchNotifier {
  @override
  set onError(_i3.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Stream<List<_i5.GithubRepoModel>> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<List<_i5.GithubRepoModel>>.empty(),
        returnValueForMissingStub:
            _i4.Stream<List<_i5.GithubRepoModel>>.empty(),
      ) as _i4.Stream<List<_i5.GithubRepoModel>>);
  @override
  List<_i5.GithubRepoModel> get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: <_i5.GithubRepoModel>[],
        returnValueForMissingStub: <_i5.GithubRepoModel>[],
      ) as List<_i5.GithubRepoModel>);
  @override
  set state(List<_i5.GithubRepoModel>? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i5.GithubRepoModel> get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: <_i5.GithubRepoModel>[],
        returnValueForMissingStub: <_i5.GithubRepoModel>[],
      ) as List<_i5.GithubRepoModel>);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<String> searchQuery(
    String? searchText,
    String? page,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchQuery,
          [
            searchText,
            page,
          ],
        ),
        returnValue: _i4.Future<String>.value(''),
        returnValueForMissingStub: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  void updateForTest(List<_i5.GithubRepoModel>? updatedList) =>
      super.noSuchMethod(
        Invocation.method(
          #updateForTest,
          [updatedList],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool updateShouldNotify(
    List<_i5.GithubRepoModel>? old,
    List<_i5.GithubRepoModel>? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i3.RemoveListener addListener(
    _i6.Listener<List<_i5.GithubRepoModel>>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
        returnValueForMissingStub: () {},
      ) as _i3.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}