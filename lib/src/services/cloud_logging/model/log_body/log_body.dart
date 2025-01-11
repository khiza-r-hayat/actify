import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_body.freezed.dart';
part 'log_body.g.dart';

@freezed
class LogBody with _$LogBody{
  const factory LogBody({
    String? userId,
    String? email,
    String? additionalData,
    String? clientSideData,
    String? appVersion,
    String? scanCode,
    @Default("") String? impersonatedLevel1,
    @Default("") String? impersonatedLevel2,
  }) = _LogBody;
  const LogBody._();

  factory LogBody.fromJson(Map<String,dynamic> json) => _$LogBodyFromJson(json);
}