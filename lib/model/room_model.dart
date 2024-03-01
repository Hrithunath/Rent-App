import 'package:hive/hive.dart';
part 'room_model.g.dart';

@HiveType(typeId: 1)
class RoomModel extends HiveObject {
  @HiveField(0)
  final String room;
  @HiveField(1)
  final String floor;
  @HiveField(2)
  final String guests;
  @HiveField(3)
  final String bed;
  @HiveField(4)
  final String rent;
  @HiveField(5)
  final String image;

  RoomModel(
      {required this.room,
      required this.floor,
      required this.guests,
      required this.bed,
      required this.rent,
      required this.image});
}
