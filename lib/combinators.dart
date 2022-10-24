library internal;

List<int> stringAsDigits(String str) => str
    .split('')
    .where((c) => c.codeUnitAt(0) ^ 0x30 <= 9)
    .map(int.parse)
    .toList();
