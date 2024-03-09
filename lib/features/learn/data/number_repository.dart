import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recall_table/features/learn/domain/number.dart';

final hiveNumberProvider = Provider<HiveNumberRepository>((ref) {
  return HiveNumberRepository();
});

class HiveNumberRepository {
  static const String boxName = 'numbersBox';

  Future<Box<Number>> get _numberBox async =>
      await Hive.openBox<Number>(boxName);

  Future<String?> getNumberWord(int index) async {
    final box = await _numberBox;
    final Number? number =
        box.get(index, defaultValue: Number(value: index, word: ""));
    return number?.word;
  }

  Future<void> saveNumberWord(int index, String word) async {
    final box = await _numberBox;
    final number = Number(value: index, word: word);
    await box.put(index, number);
  }
}
