import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:recall_table/features/learn/domain/number.dart';

final learnRepositoryProvider = Provider<LearnRepository>((ref) {
  return LearnRepository();
});

class LearnRepository {
  static const _boxName = 'numberBox';

  Future<Box<Number>> _openBox() async {
    return await Hive.openBox<Number>(_boxName);
  }

  Future<void> saveNumber(Number number) async {
    final box = await _openBox();
    await box.put(number.value, number);
  }

  Future<Number?> getNumber(int value) async {
    final box = await _openBox();
    return box.get(value);
  }

  Future<Map<int, Number>> getAllNumbers() async {
    final box = await _openBox();
    return box.toMap().cast<int, Number>();
  }
}
