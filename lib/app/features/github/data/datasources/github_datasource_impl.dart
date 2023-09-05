import 'package:dio/dio.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/extensions/status_code_extension.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/simplified_user.dart';
import '../models/simplified_user_model.dart';
import '../models/user_model.dart';
import 'github_datasource.dart';

class GitHubDataSourceImpl implements GitHubDataSource {
  final Dio client;

  GitHubDataSourceImpl(this.client);

  @override
  Future<List<SimplifiedUser>> searchUser(String query) async {
    final response = await client.get('$baseUrl/search/users?q=$query');

    if (response.statusCode.isSuccessCode) {
      return SimplifiedUserModel.fromJsonList(response.data['items']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String username) async {
    final response = await client.get('$baseUrl/users/$username');

    if (response.statusCode.isSuccessCode) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
