import 'package:actify/src/models/checklist/checklist_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklists.freezed.dart';
part 'checklists.g.dart';

@freezed
class Checklists with _$Checklists{
  const factory Checklists({
    List<ChecklistItem>? safety,
    List<ChecklistItem>? dry,
    List<ChecklistItem>? wet,
  }) = _Checklists;
  const Checklists._();

  factory Checklists.fromJson(Map<String,dynamic> json) => _$ChecklistsFromJson(json);
}