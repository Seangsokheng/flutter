void main (){
  const pizzaPrices = { 
  'margherita': 5.5, 
  'pepperoni': 7.5, 
  'vegetarian': 6.5, 
}; 
  const orders = ['margherita', 'pepperoni','mango','apple']; 
  double totals = 0;
  bool found;
    for (var order in orders){
      found = false;
      pizzaPrices.forEach((key,value){
        if(order == key){
          totals += value;
          found = true;
        }
      });
      if(!found){
        print("$order is not in the menus");
      }
    };
  print("Totals : \$$totals");
}