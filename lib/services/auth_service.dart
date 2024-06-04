import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphQL_service.dart';

class AuthService {
  Future<Map<String, dynamic>?> registerUser({
    required String email,
    required String username,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String address,
    required String gender,
    required String image,
  }) async {
    const String registerMutation = """
      mutation RegisterUser(
        \$email: String!,
        \$username: String!,
        \$password: String!,
        \$phoneNumber: String!,
        \$firstName: String!,
        \$lastName: String!,
        \$address: String!,
        \$gender: String!,
        \$image: String!,
      ) {
        register(
          email: \$email,
          username: \$username,
          password: \$password,
          phoneNumber: \$phoneNumber,
          firstName: \$firstName,
          lastName: \$lastName,
          address: \$address,
          image: \$image
          )
        {
          id
          email
          username
          phoneNumber
          firstName
          lastName
          address
          gender
          image
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(registerMutation),
      variables: {
        'email': email,
        'username': username,
        'password': password,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'gender': gender,
        'image': image,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    return result.data?['register'];
  }

  //Login
  Future<Map<String, dynamic>?> loginUser({
    required String username,
    required String password,
  }) async {
    String loginMutation = """
      mutation Login {
    login(request: { 
      username: "$username",
      password: "$password"
      }) {
        token
    }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(loginMutation),
      variables: {
        'username': username,
        'password': password,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    return result.data?['login'];
  }
}
