void main() {
  var state = EnumValues.init;
  switch (state) {
    case EnumValues.init:
    // TODO: Handle this case.
    case EnumValues.hard:
    // TODO: Handle this case.
  }
}

enum EnumValues {
  init(value: 'init'),
  hard(value: 'hard');

  const EnumValues({required this.value});

  final String value;
}
