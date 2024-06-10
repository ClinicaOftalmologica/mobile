import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/graphQL.dart';
import '../model/medication.dart';
import '../share_preferens/user_preferences.dart';

class MedicationService {
  Future<List<Medication>?> getMedications() async {
    String getMedicationsQuery = """
      query GetTratamiento {
    getTratamiento {
        id
        detail
        title
        recipe
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
      document: gql(getMedicationsQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<Medication> medications = [];

    for (final json in result.data!['getTratamiento']) {
      medications.add(Medication.fromJson(json));
    }

    return medications;
  }
}
