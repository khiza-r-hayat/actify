import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_item.freezed.dart';
part 'checklist_item.g.dart';

@freezed
class ChecklistItem with _$ChecklistItem{
  const factory ChecklistItem({
    String? webformId,
    String? name,
    String? sid,
    String? value,
  }) = _ChecklistItem;
  const ChecklistItem._();

  factory ChecklistItem.fromJson(Map<String,dynamic> json) => _$ChecklistItemFromJson(json);
}