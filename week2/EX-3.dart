class MyDuration {
  final int _milliseconds;
  MyDuration._(this._milliseconds);

  factory MyDuration.fromHours(int hours) {
    return MyDuration._(hours * 60 * 60 * 1000);
  }

  factory MyDuration.fromMinutes(int minutes) {
    return MyDuration._(minutes * 60 * 1000);
  }

  factory MyDuration.fromSeconds(int seconds) {
    return MyDuration._(seconds * 1000);
  }

  MyDuration operator +(MyDuration other) {
    return MyDuration._(_milliseconds + other._milliseconds);
  }

  MyDuration operator -(MyDuration other) {
    int result = _milliseconds - other._milliseconds;
    if (result < 0) throw Exception("Duration cannot be negative!");
    return MyDuration._(result);
  }

  bool operator >(MyDuration other) {
    return _milliseconds >= other._milliseconds;  // Should be just >
  }

  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.fromHours(3); // 3 hours
  MyDuration duration2 = MyDuration.fromMinutes(45); // 45 minutes

  // Correct output: 3 hours, 45 minutes, 0 seconds
  print(duration1 + duration2);

  // Subtle mistake: comparison will return true incorrectly in some cases
  print(duration1 > duration2); // true

  // This will throw an exception if duration2 is subtracted from duration1
  try {
    print(duration2 - duration1); // Exception: Duration cannot be negative!
  } catch (e) {
    print(e);
  }
}
