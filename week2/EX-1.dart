enum Skill { FLUTTER, DART, OTHER }

class Address{
  String stress;
  String city;
  String zipCode;
  Address(this.city,this.stress, this.zipCode);
}

class Employee {
  String _name;
  double _baseSalary;
  int _yearOfExperince;
  Address _address;
  List<Skill> _skills;
  
  Employee(this._name, this._baseSalary, this._yearOfExperince, this._address, this._skills);

  Employee.mobileDeveloper(this._address, this._baseSalary, this._name, this._yearOfExperince): _skills = [Skill.FLUTTER, Skill.DART];

  String get name => _name;
  double get baseSalary => _baseSalary;
  int get yearOfExperince => _yearOfExperince;
  Address get address => _address;
  List<Skill> get skills => _skills;

  double computeTheSalary() {
    double totalSalay = 40000;
    totalSalay += yearOfExperince * 2000;

    for (var skill in _skills){
      if(skill == Skill.OTHER ){
        totalSalay += 1000;
      }else if (skill == Skill.DART){
        totalSalay += 3000;
      }else if (skill == Skill.FLUTTER){
        totalSalay += 5000;
      }
    }
    return totalSalay;
  }

  void printDetails() {
    print('Employee: $name, Base Salary: \$${baseSalary}');
  }
}

void main() {
  Address ad1 = Address("city", "stress", "zipCode");

  Employee emp1 = Employee("sokkea", 40000, 5, ad1,[Skill.DART]);
  // emp1.printDetails();

  Employee softwareDeveloper = Employee.mobileDeveloper(ad1, 40000, "_name", 3,);
  // softwareDeveloper.printDetails();

  print("Total : Salary ${softwareDeveloper.computeTheSalary()}");
  print("Total : Salary of em1 ${emp1.computeTheSalary()}");
}