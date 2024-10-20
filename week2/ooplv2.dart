void main() {
  Shape shape = Shape(Point(5, 4), Point(2, 2));
  print(shape.toString());
  print("height: ${shape.height}");
  print("width: ${shape.width}");
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  Point translate(double dx, double dy) {
    return Point(x + dx, y + dy);
  }

  @override
  String toString() {
    return "Point($x, $y)";
  }
}

class Shape {
  Point rightTop;
  Point leftBottom;

  Shape(this.rightTop, this.leftBottom);

  get width {
    return rightTop.x - leftBottom.x;
  }

  get height {
    return rightTop.y - leftBottom.y;
  }

  @override
  String toString() {
    return "(${rightTop.x}, ${rightTop.y}), (${leftBottom.x}, ${leftBottom.y})";
  }
}