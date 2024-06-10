import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/graphQL.dart';
import '../model/reservation.dart';
import '../share_preferens/user_preferences.dart';

class ReservationService {
  Future<Map<String, dynamic>?> createReservation(
      {required String idTimeTable}) async {
    print('idTimeTable: $idTimeTable');
    String createReservationMutation = """
      mutation SaveReservation {
        saveReservation(
          request: {
            place: "Hospital Militar",
            available_time_id: "$idTimeTable"
            }
            )
          {
            id
            place
            state
            available_time {
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
      }
    """;

    final prefs = UserPreferences();
    final token = prefs.token;

    print('Token: $token');

    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link link = authLink.concat(HttpLink(endpointGraphQL));

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    final MutationOptions options = MutationOptions(
      document: gql(createReservationMutation),
      variables: {
        'place': 'Hospital Militar',
        'available_time_id': idTimeTable,
      },
    );

    final QueryResult result = await client.mutate(options);

    print('Result: ${result.data}');

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return null;
    }

    return result.data?['saveReservation'];
  }

  Future<List<Reservation>?> getReservations() async {
    try {
      String getReservationsQuery = """
      query GetReservaPendiente {
    getReservaPendiente {
        id
        place
        state
        available_time {
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
            }
        }
    }
}
    """;

      final prefs = UserPreferences();
      final token = prefs.token;

      print('Token: $token');

      final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

      final Link link = authLink.concat(HttpLink(endpointGraphQL));

      final GraphQLClient client = GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      );

      final QueryOptions options = QueryOptions(
        document: gql(getReservationsQuery),
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        /* print('Exception: ${result.exception.toString()}'); */

        // Verificando si el error es específicamente un error 'UNAUTHORIZED'
        if (result.exception!.graphqlErrors.any((gError) =>
            gError.extensions?['classification'] == 'UNAUTHORIZED')) {
          throw Exception('Unauthorized access detected.');
        }

        return null;
      }

      List<Reservation> reservations = [];

      print('Result: ${result.data}');

      for (var item in result.data?['getReservaPendiente']) {
        reservations.add(Reservation.fromJson(item));
      }
      return reservations;
    } catch (e) {
      /* print('Error: $e'); */
      if (e.toString() == 'Exception: Unauthorized access detected.') {
        /* print('Unauthorized access detected.'); */
        throw Exception('Unauthorized access detected.');
      }
    }
  }

  Future<bool> cancelReservation({required id}) async {
    String idReservation = id.toString();
    String cancelReservationMutation = """
      mutation CancelReserva {
      cancelReserva(id: "$idReservation") {
        id
        place
        state
        available_time {
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
            }
        }
      }
    }
    """;

    final prefs = UserPreferences();
    final token = prefs.token;

    print('Token: $token');

    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link link = authLink.concat(HttpLink(endpointGraphQL));

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    final MutationOptions options = MutationOptions(
      document: gql(cancelReservationMutation),
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        'id': id,
      },
    );

    final QueryResult result = await client.mutate(options);

    print('Result: ${result.data}');

    if (result.hasException) {
      print('Exception: ${result.exception.toString()}');
      return false;
    }

    //return result.data?['cancelReservation'];
    if (result.data?['cancelReserva'] != null) {
      return true;
    } else {
      return false;
    }
  }
}
