import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphQL_service.dart';
import '../constants/graphQL.dart';
import '../model/timetable.dart';
import '../share_preferens/user_preferences.dart';

class TimetableService {
  Future<List<Timetable>?> getTimetable() async {
    String timetableQuery = """
      query GetHorarioDisponible {
        getHorarioDisponible {
          id
          date
          time
          doctor {
            id
            name
            lastName
            address
            ci
            sexo
            contactNumber
            titulo
            user {
                id
                username
                email
                role
            }
          }
        }
      }
    """;

    final prefs = UserPreferences();
    final token = prefs.token;

    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link link = authLink.concat(HttpLink(endpointGraphQL));

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    final QueryOptions options = QueryOptions(
      document: gql(timetableQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    List<Timetable> timetable = [];

    for (var item in result.data?['getHorarioDisponible']) {
      timetable.add(Timetable.fromJson(item));
    }

    return timetable;
  }
}
