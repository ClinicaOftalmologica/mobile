import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphQL_service.dart';
import '../model/reservation.dart';

class ReservationService {
  Future<Map<String, dynamic>?> createReservation({required String idTimeTable}) async {
    String createReservationMutation = """
      mutation SaveReservation {
        saveReservation(request: { available_time_id: "$idTimeTable" }) {
          id
          place
          state
          available_time {
            id
            date
            time
          }
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(createReservationMutation),
      variables: {
        'available_time_id': idTimeTable,
      },
    );

    final QueryResult result = await GraphQLService.client.mutate(options);

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    final reservation = Reservation.fromJson(result.data?['saveReservation']);

    return reservation.toJson();
  }
}