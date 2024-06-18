import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:medilab_prokit/config/dio_ia_image_config.dart';

import '../config/graphQL_service.dart';
import '../model/user.dart';
import '../share_preferens/user_preferences.dart';

class AuthService {
  Future<Map<String, dynamic>?> registerUser(
      {required email,
      required password,
      required name,
      required lastName,
      required address,
      required identification,
      required image,
      required gender,
      required phoneNumber,
      required birthDate}) async {
    String registerMutation = """
      mutation Register {
        register(
          request: {
          email: "$email",
          password: "$password",
          name: "$name",
          last_name: "$lastName",
          address: "$address",
          ci: "$identification",
          sexo: "$gender",
          contact_number: "$phoneNumber",
          birth_date: "$birthDate",
          url: "$image"
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
        'email': email,
        'password': password,
        'name': name,
        'last_name': lastName,
        'address': address,
        'ci': identification,
        'sexo': gender,
        'contact_number': phoneNumber,
        'birth_date': birthDate,
        'url': image,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    User userData = User(
      email: email,
      token: result.data?['register']['token'],
    );

    UserPreferences.saveUserPreferences(userData);

    return result.data?['register'];
  }

  //Login
  Future<Map<String, dynamic>?> loginUser({
    required email,
    required password,
  }) async {
    String loginMutation = """
      mutation Login {
    login(request: {
      email: "$email",
      password: "$password"
      }) {
        token
    }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(loginMutation),
      variables: {
        'email': email,
        'password': password,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    User userData = User(
      email: email,
      token: result.data?['login']['token'],
    );

    UserPreferences.saveUserPreferences(userData);

    return result.data?['login'];
  }

  Future<Map<String, dynamic>?> compareImage({required File image}) async {
    try {
      final prefs = UserPreferences();
      String email = prefs.email;

      FormData formData = FormData.fromMap({
        'email': email,
        'image': await MultipartFile.fromFile(image.path),
      });

      final response = await DioConfig.dioWithoutAuthorization.post(
        '/auth/login',
        data: formData,
      );

      prefs.isLogged = true;
      var data = response.data;

      return data;
    } catch (e) {
      throw Exception('Error al obtener el email del usuario');
    }
  }
}
