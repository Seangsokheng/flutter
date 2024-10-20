//1. inference
// void main() {
  
//   var number = 10;
//   var name = 'sokheng';
//   print("number $number (type: ${number.runtimeType})" );
//   print("My name is $name (type: ${name.runtimeType})");
// }
//2. nullable and non-nullable
// void main (){
//   int? nullable = null;
//   int nonNullable = 10;

//   nullable = 20;
//   print ("nullable: $nullable");
//   print ("non-nullable: $nonNullable");
// }

//3.final and const
// void main(){
//  // Declare a final variable and assign it the current date and time
// final currentDate = DateTime.now();
//  //no you can not declear this variable as const because const assign before runtime and the datetime get during the runtime
//  const number = 10;
//  // no, we can not declear final again once we assign already because we can assign only once time
//  //currentDate = DateTime.now();
//  print("the date : $currentDate");
//  print("number : $number");
// }

//4.
// void main (){
//   // Declare two strings: firstName and lastName and an integer:age
//     String firstName = "seang";
//     String lastname = "sokheng";
//     int age = 20;
//     // Concatenate the 2 strings and the age 
//     String result = firstName + lastname + " is " + age.toString() +"years old";
//     // Print result
//     print ("Result : $result");
// }
// void main (){
//   // Create a list of integers
//     List<int> numbers = [10,20,30,40,50]; 
//     // Add a number to the list
//     numbers.add(60);
//     // Remove a number from the list
//     numbers.remove(30);
//     // Insert a number at a specific index in the list
//     numbers.insert(2, 25);
//     // Iterate over the list and print each number
//     for ( int number in numbers){
//       print("$number,");
//     }
// }

// void main (){
//   // Create a map with String keys and integer values
//     Map<String,int> myMap = {
//       "apple" : 10,
//       "banana" : 20,
//       "orange" : 30
//     };
//     // Add a new key-value pair to the map
//     myMap["mango"] = 40;
//     // Remove a key-value pair from the map
//     myMap.remove("banana");
//     // Iterate over the map and print each key-value pair
//     myMap.forEach((key, value) {
//       print("$key : $value");
//     });
// }
//5.
// void main(){
//   // Use a for-loop to print numbers from 1 to 5
// for (int i =1 ; i <=5 ; i++){
//   print("For-loop $i");
// }
// // Use a while-loop to print numbers while a condition is true
// int u = 1 ;
// while (u<=5){
//   print("while-loop $u");
//   u++;
// };
// // Use an if-else statement to check if a number is even or odd 
// int i =1;
// while (i<=10){
//   if(i %2== 0){
//     print("this is even $i");
//   }else{
//     print("this is odd $i");
//   }
//   i++;
// }
// }
//6.
// void add(int a,int b){
// 	print(a+b);
// 	}
//     void main (){
//         add(5,10); //5 is a because a is the first argument position
//     } 
// void main (){
//     // Define a function that uses positional arguments
//     int multiple(int a,int b){
//         return a * b;
//     }
//     // Define another function that uses named arguments with the required keyword (ex: getArea with rectangle arguments)
//     int getArea ({required int width, required int height}){
//         return width * height;
//     }
//     // Call both functions with appropriate arguments
//     int product = multiple(5, 10);
//     print("this is product $product");
    
//     int area = getArea(width: 5, height: 20);
//     print ("this is area $area");
// }
// int plus(int a,int b){
//     return a + b;
// }
// int plusCorrect(int a,[int b = 5]){
//     return a + b;
// }
// void main (){
//     //plus(5); //this will be error because they require all the value
//     int result = plusCorrect(5); //output is 10
//     print("Result $result");
// }

// int plus({int a =20, int b= 10 , required int c }){
//     return a + b + c;
// }
// void main(){
//     int result = plus(c: 30);
//     print("Result : $result"); //output 60
// }

// void main (){
//     // Define a function using arrow syntax that squares a number
//     int squares (int x) => 
//     x*x;
//     // Call the arrow function and print the result
//     print("Result : ${squares(4)}");//output is 16
// }
	void main (){
        var socre = [1,2,3];
        socre = [1,2,3,4];
        print(socre);
    }
