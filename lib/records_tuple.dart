import 'package:tuple/tuple.dart';

void main() {
  final record = getValue();

  print(record.item1);
  print(record.item2);

  final recordNative = getValueNative();

  var (a, b) = recordNative;

  print(a);
  print(b);
}

Tuple2<String, int> getValue() {
  const t = Tuple2<String, int>('a', 10);

  return t;
}

(String, int) getValueNative() {
  const t = ('a', 10);

  return t;
}
