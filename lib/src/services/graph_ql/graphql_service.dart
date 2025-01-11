// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils/instances.dart';

/// An abstract class which contains all the required APIs for the app.
abstract class GraphQLApi {
  /// Initialises GraphQL client
  Future<GraphQLClient> initGraphQL();
}

/// A service used for all the API operations.
class GraphQLService extends GraphQLApi {
  /// Constructor for GraphQLService.
  GraphQLService();

  @override
  Future<GraphQLClient> initGraphQL() async {
    String? token = await auth.currentUser!.getIdToken();
    // log('token jwt: $token');
    String subEndPoint = dotenv.env['SUB_END_POINT']!;
    String hasuraGql = dotenv.env['GRAPHQL_URL']!;

    Link httpLink =
    HttpLink(hasuraGql, defaultHeaders: {"Authorization": 'Bearer $token'});
    // HttpLink(hasuraGql, defaultHeaders: {"X-Hasura-Admin-Secret": key});

    final WebSocketLink websocketLink = WebSocketLink(subEndPoint);

    httpLink = Link.split(
            (request) => request.isSubscription, websocketLink, httpLink);

    return GraphQLClient(link: httpLink, cache: GraphQLCache());
  }
}

final graphQLProvider = Provider<GraphQLApi>((ref) {
  return GraphQLService();
});
