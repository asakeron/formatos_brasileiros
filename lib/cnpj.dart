import 'dart:math';

import 'package:meta/meta.dart';

import 'combinators.dart';

@sealed
@immutable
class Cnpj {
  final String _value;

  const Cnpj._(this._value);

  static Cnpj fromString(String cnpj) {
    if (!isValid(cnpj)) {
      throw FormatException();
    }

    return Cnpj._(cnpj);
  }

  static Cnpj generate([int? seed]) {
    final randomGenerator = Random(seed);
    final digits = [for (var i = 1; i <= 12; i++) randomGenerator.nextInt(10)];
    final consts = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final consts2 = [6, ...consts];

    final sum1 = [for (var i = 0; i <= 11; i++) digits[i] * consts[i]]
            .fold(0, (x, y) => x + y) %
        11;
    final dv1 = sum1 < 2 ? 0 : 11 - sum1;

    final digits2 = [...digits, dv1];
    final sum2 = ([for (var i = 0; i <= 12; i++) digits2[i] * consts2[i]])
            .fold(0, (x, y) => x + y) %
        11;
    final dv2 = sum2 < 2 ? 0 : 11 - sum2;

    return Cnpj._([...digits2, dv2].toString());
  }

  static bool isValid(String cnpj) {
    final digits = stringAsDigits(cnpj);

    if (digits.length != 14) {
      return false;
    }

    final consts = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final consts2 = [6, ...consts];

    final sum1 = [for (var i = 0; i <= 11; i++) digits[i] * consts[i]]
            .fold(0, (x, y) => x + y) %
        11;

    final sum2 = ([for (var i = 0; i <= 12; i++) digits[i] * consts2[i]])
            .fold(0, (x, y) => x + y) %
        11;
    final dv1 = sum1 < 2 ? 0 : 11 - sum1;
    final dv2 = sum2 < 2 ? 0 : 11 - sum2;

    return dv1 == digits[12] && dv2 == digits[13];
  }

  @override
  String toString() => _value;

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) => other is Cnpj && other._value == _value;
}
