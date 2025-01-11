import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity{
  const factory Activity({
    String? id,
    String? supervisorId,
    String? supervisorName,
    String? activityId,
    String? activityTypeId,
    String? activityTypeName,
    String? activityTitle,
    String? activityPitch,
    String? activityStartDate,
    String? activityEndDate,
    String? channelId,
    String? isDoorKnocks,
    String? isGiveAways,
    String? isInterceptions,
    String? isSOGs,
    String? targetKnocks,
    String? productivityTarget,
    String? plannedSellingStock,
    String? plannedSOGStock,
    String? dryChecklist,
    String? safetyChecklist,
    String? wetChecklist,
  }) = _Activity;
  const Activity._();

  factory Activity.fromJson(Map<String,dynamic> json) => _$ActivityFromJson(json);
}