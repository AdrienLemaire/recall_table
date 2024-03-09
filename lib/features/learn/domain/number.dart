import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'number.freezed.dart';
part 'number.g.dart';

@freezed
class Number with _$Number {
  @HiveType(typeId: 0)
  const factory Number({
    @HiveField(0) required int value,
    @HiveField(1) @Default("") String word,
  }) = _Number;

  factory Number.fromJson(Map<String, dynamic> json) => _$NumberFromJson(json);
}
