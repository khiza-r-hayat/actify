import 'dart:developer';
import 'dart:io';

import 'package:actify/src/services/cloud_logging/query.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../fetures/splash_screen/splash_screen.dart';
import '../../utils/instances.dart';
import '../graph_ql/graphql_service.dart';

import 'model/log_body/log_body.dart';
import 'model/log_message/log_message.dart';
import 'model/log_model/log_model.dart';

class CloudLoggingMutation {
  final GraphQLApi api;

  CloudLoggingMutation(this.api);

  Future<dynamic> sendLog(LogModel request) async {
    GraphQLClient client = await api.initGraphQL();
    final mutation = QueryOptions(
        document: CloudLogging.log, variables: {"request": request});

    try {
      final result = await client.query(mutation);

      // log("Log Result $result");
      return result.data;
    } catch (e) {
      log("Logging Error $e");
      rethrow;
    }
  }
}

final cloudLogging = Provider<CloudLoggingMutation>(
        (ref) => CloudLoggingMutation(ref.read(graphQLProvider)));


final cloudLoggingProvider =
FutureProvider.family<dynamic, LogMessage>((ref, message) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final BaseDeviceInfo deviceInformation;
  if (Platform.isIOS) {
    deviceInformation = await deviceInfo.iosInfo;
  } else if (Platform.isAndroid) {
    deviceInformation = await deviceInfo.androidInfo;
  } else {
    deviceInformation = await deviceInfo.deviceInfo;
  }

  // final userData = ref.watch(homeProvider);
  final mutation = ref.watch(cloudLogging);

  final LogModel cloudLogRequest = LogModel(
      message: message.message,
      level: message.type,
      body: LogBody(
          appVersion: packageInfo!.version??"",
          userId: 'userData.id' ?? auth.currentUser?.uid ?? "",
          email:
          message.email ?? 'userData.email' ?? auth.currentUser?.email ?? "",
          clientSideData: deviceInformation.toString(),
          additionalData: message.additionalData ?? "",
          scanCode: message.scanCode??""));
  // log('cloudLogRequest: $cloudLogRequest');
  final data = await mutation.sendLog(cloudLogRequest);
  return data;
});
