import 'package:test/test.dart';

import 'package:formatos_brasileiros/cpf.dart';

void main() {
  const validExample = '821.797.270-20';
  const invalidExample = '821.797.270-21';

  test('Cpf instances can be created from valid string encoded values', () {
    expect(Cpf.isValid(validExample), equals(true));
    final instance = Cpf.fromString(validExample);
    expect(instance.toString(), equals(validExample));
  });

  test('Cpf instances cannot be created from invalid string encoded values',
      () {
    expect(Cpf.isValid(invalidExample), equals(false));
    expect(() => Cpf.fromString(invalidExample), throwsFormatException);
  });

  test('Cpf instances can be generated from random sources', () {
    final instance = Cpf.generate();
    expect(Cpf.isValid(instance.toString()), equals(true));
  });
}
