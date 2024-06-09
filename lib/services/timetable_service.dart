import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphQL_service.dart';
import '../model/timetable.dart';

class TimetableService {
  Future<List<Timetable>?> getTimetable() async {
    String timetableQuery = """
      query GetHorarioDisponible {
        getHorarioDisponible {
          id
          date
          time
        }
      }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(timetableQuery),
    );

    final QueryResult result = await GraphQLService.client.query(options);

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
