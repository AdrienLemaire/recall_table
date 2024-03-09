import 'package:freezed_annotation/freezed_annotation.dart';

part 'sequence.freezed.dart';
part 'sequence.g.dart';

@freezed
class Sequence with _$Sequence {
  const factory Sequence({
    required String label,
    required List<int> sequence,
  }) = _Sequence;

  factory Sequence.fromJson(Map<String, dynamic> json) =>
      _$SequenceFromJson(json);
}
