import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_message.freezed.dart';
part 'log_message.g.dart';

@unfreezed
class LogMessage with _$LogMessage {
  factory LogMessage({
    String? email,
    String? message,
    @Default('info') String? type,
    String? additionalData,
    String? scanCode,
  }) = _LogMessage;
  LogMessage._();

  factory LogMessage.fromJson(Map<String, dynamic> json) =>
      _$LogMessageFromJson(json);
}
