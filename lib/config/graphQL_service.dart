import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:medilab_prokit/constants/graphQL.dart';

class GraphQLService {
  static HttpLink httpLink = HttpLink(
    endpointGraphQL,
  );

  static final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );

  static final GraphQLClient client = _client;
}