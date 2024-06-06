import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphQL_service.dart';
import '../model/user.dart';
import '../share_preferens/user_preferences.dart';

class AuthService {
  Future<Map<String, dynamic>?> registerUser({required User user}) async {
    String registerMutation = """
      mutation Register {
        register(
          request: {
          email: "${user.email}",
          password: "${user.password}",
          name: "${user.name}",
          last_name: "${user.lastName}",
          address: "${user.address}",
          ci: "${user.identification}",
          sexo: "${user.gender}",
          contact_number: "${user.phoneNumber}",
          birth_date: "${user.birthDate}",
          url: "${user.image}"
          }
          )
        {
          token
          message
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(registerMutation),
      variables: {
        'email': user.email,
        'password': user.password,
        'name': user.name,
        'last_name': user.lastName,
        'address': user.address,
        'ci': user.identification,
        'sexo': user.gender,
        'contact_number': user.phoneNumber,
        'birth_date': user.birthDate,
        'url': user.image,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    User userData = user.copyWith(token: result.data?['register']['token']);

    UserPreferences.saveUserPreferences(userData);

    return result.data?['register'];
  }

  //Login
  Future<Map<String, dynamic>?> loginUser({
    required User user,
  }) async {
    String loginMutation = """
      mutation Login {
    login(request: {
      username: "${user.username}",
      password: "${user.password}"
      }) {
        token
    }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(loginMutation),
      variables: {
        'username': user.username,
        'password': user.password,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    User userData = user.copyWith(token: result.data?['login']['token']);

    UserPreferences.saveUserPreferences(userData);

    return result.data?['login'];
  }
}
