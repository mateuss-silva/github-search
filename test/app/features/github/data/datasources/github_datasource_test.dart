import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/core/common/constants.dart';
import 'package:github_search/app/core/error/exceptions.dart';
import 'package:github_search/app/features/github/data/datasources/github_datasource_impl.dart';
import 'package:github_search/app/features/github/data/models/simplified_user_model.dart';
import 'package:github_search/app/features/github/data/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_render.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late MockDioClient mockDioClient;
  late GitHubDataSourceImpl githubDataSource;

  setUp(() {
    mockDioClient = MockDioClient();
    githubDataSource = GitHubDataSourceImpl(mockDioClient);
  });

  final tSearchResult = SimplifiedUserModel.fromJsonList(
      json.decode(fixture("search_result.json"))["items"]);

  final tUser = UserModel.fromJson(json.decode(fixture("user.json")));

  test('should perform a GET on a url with search user being the endpoint',
      () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        data: json.decode(fixture("search_result.json")),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    await githubDataSource.searchUser("mat");

    // assert
    verify(() => mockDioClient.get("$baseUrl/search/users?q=mat"));
  });

  test('should perform a GET on a url with user by username being the endpoint',
      () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        data: json.decode(fixture("user.json")),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    await githubDataSource.getUser("mateuss-silva");

    // assert
    verify(() => mockDioClient.get('$baseUrl/users/mateuss-silva'));
  });

  test(
      'should return a List of SimplifiedUserModel when the response code is 200',
      () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        data: json.decode(fixture("search_result.json")),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final result = await githubDataSource.searchUser("mat");

    // assert
    expect(result, tSearchResult);
  });

  test('should return a UserModel when the response code is 200', () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        data: json.decode(fixture("user.json")),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final result = await githubDataSource.getUser("mateuss-silva");

    // assert
    expect(result, tUser);
  });

  test(
      'should throw a ServerException when the response of search user code is 404 or other',
      () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        statusCode: 404,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final call = githubDataSource.searchUser;

    // assert
    expect(() => call("mat"), throwsA(isA<ServerException>()));
  });

  test(
      'should throw a ServerException when the response of get user by username code is 404 or other',
      () async {
    // arrange
    when(() => mockDioClient.get(any())).thenAnswer(
      (_) async => Response(
        statusCode: 404,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final call = githubDataSource.getUser;

    // assert
    expect(() => call("mat"), throwsA(isA<ServerException>()));
  });
}
