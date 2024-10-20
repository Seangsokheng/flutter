enum Country { CAMBODIA, FRANCE, USA }

class Address {
  final Country country;

  final String city;

  final String street;

  Address({this.country=Country.CAMBODIA, required this.city, required this.street});

  @override
  String toString(){
    return "${ country.name} - $city - $street";
  }
}

enum Color {black , red , yellow}

class Door {
  Color color;
  Door({required this.color});
  String toString (){
    return "Door color: $color";
  }
}

class Window {
  final double height;
  final double width;

  Window({required this.height , required this.width});
  String toString (){
    return "Window : $height cm , $width cm ";
  }
}

enum RoomType { Bathroom , BedRoom , kitchen}

class Room {
  final RoomType roomType;
  final Door door;
  final Window window ;
  Room ({required this.door, required this.roomType , required this.window});

  String toString(){
    return "Room : $roomType - $door - $window";
  }
}

class House{
  final Address address;
  final List<Room> rooms = [];

  House({required this.address});

  void addRoom(Room newRoom){
    this.rooms.add(newRoom);
  }
  
  String toString(){
    return "My home : $rooms - $address";
  }
}
void main() {
  Address myAdress = Address(street: "CADT", city: "SiemReap" );

  House myhome = House(address: myAdress);
  // height and width calclate in cm 
  Window windowSide = Window(height: 20, width: 30);

  Door blackDoor = Door(color: Color.black);
  Door redDoor = Door(color: Color.red);
  Door yellowDoor = Door(color: Color.yellow);

  Room BedRoom = Room(door: blackDoor , roomType: RoomType.BedRoom, window: windowSide );
  Room Bathroom = Room(door: redDoor, roomType: RoomType.Bathroom , window: windowSide);
  Room kitchen = Room(door: yellowDoor , roomType: RoomType.kitchen, window: windowSide);

  myhome.addRoom(BedRoom);
  myhome.addRoom(Bathroom);
  myhome.addRoom(kitchen);

  print(myAdress);
  print(myhome);
}