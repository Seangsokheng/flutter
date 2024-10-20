class Distance {
  final double _meters;

  Distance.kms(double kms) : _meters = kms * 1000;

  Distance.meters(double meters) : _meters = meters;

  Distance.cms(double cms) : _meters = cms / 100;

  Distance operator +(Distance other) {
    return Distance.meters(this._meters + other._meters); 
  }

  double get kms => _meters / 1000;

  double get cms => _meters * 100;

  double get meters => _meters;
}

void main() {
  Distance d1 = Distance.kms(3.4);
  Distance d2 = Distance.meters(1000);  

  Distance result = d1 + d2;

  print(result.kms);  
  print(result.cms); 
}
