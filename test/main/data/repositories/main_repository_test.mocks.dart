// Mocks generated by Mockito 5.4.4 from annotations
// in github_search/test/main/data/repositories/main_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dio/dio.dart' as _i2;
import 'package:github_search/features/main/data/datasources/main/rest_remote_datasource.dart'
    as _i4;
import 'package:github_search/features/main/domain/enities/main_entity.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMainEntity_1 extends _i1.SmartFake implements _i3.MainEntity {
  _FakeMainEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MainRESTRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockMainRESTRemoteDataSourceImpl extends _i1.Mock
    implements _i4.MainRESTRemoteDataSourceImpl {
  MockMainRESTRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);

  @override
  _i5.Future<_i3.MainEntity> getMainInfo(
    String? query, {
    bool? isMock = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMainInfo,
          [query],
          {#isMock: isMock},
        ),
        returnValue: _i5.Future<_i3.MainEntity>.value(_FakeMainEntity_1(
          this,
          Invocation.method(
            #getMainInfo,
            [query],
            {#isMock: isMock},
          ),
        )),
      ) as _i5.Future<_i3.MainEntity>);
}