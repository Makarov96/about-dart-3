void main() {
  double radius = 5.0;

  double circleArea = Constants.calculateCircleArea(radius);
  print("Area of circle: $circleArea"); // Output: Area of circle: 78.53975
}

abstract class ClassName {
  void helloWord();
}

final class Constants extends ClassName {
  // Immutable value representing pi
  static const double PI = 3.14159;

  // Method to calculate the area of a circle
  static double calculateCircleArea(double radius) {
    return PI * radius * radius;
  }

  @override
  void helloWord() {
    // TODO: implement helloWord
  }
}
