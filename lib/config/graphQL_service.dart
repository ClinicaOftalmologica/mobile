import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilab_prokit/constants/graphQL.dart';

class GraphQLService {
  static late GraphQLClient client;

  static void init(Box<Map<dynamic, dynamic>> box) {
    HttpLink httpLink = HttpLink(endpointGraphQL);
    client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore(box)),
      link: httpLink,
    );
  }
}
