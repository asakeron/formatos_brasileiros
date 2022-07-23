import 'dart:math';

import 'package:meta/meta.dart';

@sealed
@immutable
class Cpf {
  final String _value;

  const Cpf._({required String value}) : _value = value;

  static Cpf fromString(String cpf) {
    if (!isValid(cpf)) {
      throw FormatException('cpf is not valid');
    }
    return Cpf._(value: cpf);
  }

  static Cpf generate([int? seed]) {
    final randomGenerator = Random(seed);
    final digits = [for (var i = 1; i <= 9; i++) randomGenerator.nextInt(10)];
    final sum1 = ([
              for (var i = 1; i <= 9; i++) digits.elementAt(i - 1) * (11 - i)
            ].fold(0, _sum) *
            10) %
        11;
    final sum2 = ([
              for (var i = 1; i <= 10; i++)
                [...digits, sum1 == 10 || sum1 == 11 ? 0 : sum1]
                        .elementAt(i - 1) *
                    (12 - i)
            ].fold(0, _sum) *
            10) %
        11;
    final dv1 = sum1 == 10 || sum1 == 11 ? 0 : sum1;
    final dv2 = sum2 == 10 || sum2 == 11 ? 0 : sum2;

    return Cpf._(
        value: [...digits, dv1, dv2].map((d) => d.toString()).join(''));
  }

  static int _sum(int x, int y) => x + y;

  static bool isValid(String cpf) {
    final digits =
        cpf.split('').where((c) => c.codeUnitAt(0) ^ 0x30 <= 9).map(int.parse);

    if (digits.length != 11) {
      return false;
    }

    final digitoVerificador1 = digits.elementAt(9);
    final digitoVerificador2 = digits.elementAt(10);
    final sum1 = ([
              for (var i = 1; i <= 9; i++) digits.elementAt(i - 1) * (11 - i)
            ].fold(0, _sum) *
            10) %
        11;
    final sum2 = ([
              for (var i = 1; i <= 10; i++) digits.elementAt(i - 1) * (12 - i)
            ].fold(0, _sum) *
            10) %
        11;

    final dv1Valid = ((sum1 == 10 || sum1 == 11) && 0 == digitoVerificador1) ||
        (sum1 == digitoVerificador1);
    final dv2valid = ((sum2 == 10 || sum2 == 11) && 0 == digitoVerificador2) ||
        (sum2 == digitoVerificador2);

    return dv1Valid && dv2valid;
  }

  @override
  String toString() => _value;

  @override
  get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) => other is Cpf && other._value == _value;
}
