import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilab_prokit/constants/graphQL.dart';

import '../share_preferens/user_preferences.dart';

class GraphQLService {
  static late GraphQLClient client;

  static void init(Box<Map<dynamic, dynamic>> box) {
    HttpLink httpLink = HttpLink(endpointGraphQL);
    final prefs = UserPreferences();
    final token = prefs.token;
    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');
    final Link link = authLink.concat(httpLink);
    client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore(box)),
      link: link,
    );
  }
}
