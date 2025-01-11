import 'package:graphql_flutter/graphql_flutter.dart';

abstract class CloudLogging {
  static final log = gql(r'''mutation cloudLoggingAction($request: RequestInput!) {
    googleCloudLogging(request: $request)
  }''');
}
