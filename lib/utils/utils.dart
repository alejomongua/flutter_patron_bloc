bool validNumber(value) {
  if (value.isEmpty) return false;

  final number = num.tryParse(value);

  return number != null;
}
