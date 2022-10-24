import 'package:test/test.dart';

import 'package:formatos_brasileiros/cnpj.dart';

void main() {
  const validExample = '62.533.523/0001-50';
  const invalidExample = '62.533.523/0001-51';

  test('Cnpj instances can be created from valid string encoded values', () {
    expect(Cnpj.isValid(validExample), equals(true));
    final instance = Cnpj.fromString(validExample);
    expect(instance.toString(), equals(validExample));
  });

  test('Cnpj instances cannot be created from invalid string encoded values',
      () {
    expect(Cnpj.isValid(invalidExample), equals(false));
    expect(() => Cnpj.fromString(invalidExample), throwsFormatException);
  });

  test('Cnpj instances can be generated from random sources', () {
    final instance = Cnpj.generate(0);
    expect(Cnpj.isValid(instance.toString()), equals(true));
  });
}
