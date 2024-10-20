void main(){
  List<int> scores  = [45, 78, 62, 49, 85, 33, 90, 50] ;
  var passed = scores.where((score) => score >= 50);
  print("Input : $scores");
  print("Passed Students : ${passed.toList()}");
  print("Students passed number : ${passed.length}");
}