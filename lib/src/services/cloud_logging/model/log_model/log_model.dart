import 'package:freezed_annotation/freezed_annotation.dart';

import '../log_body/log_body.dart';

part 'log_model.freezed.dart';
part 'log_model.g.dart';

@unfreezed
class LogModel with _$LogModel{
  factory LogModel({
    @Default('EGLeads-dev-mobile') String? name,
    String? message,
    LogBody? body,
    String? level,
  }) = _LogModel;
  LogModel._();

  factory LogModel.fromJson(Map<String,dynamic> json) => _$LogModelFromJson(json);
}
