import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 2)
class UserDetails extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String uploadAdhaar;
  @HiveField(4)
  final String checkin;
  @HiveField(5)
  final String checkout;
  @HiveField(6)
  final String advanceAmount;
  @HiveField(7)
  final String image;

  UserDetails({this.id,required this.name, required this.phoneNumber, required this.uploadAdhaar, required this.checkin, required this.checkout, required this.advanceAmount, required this.image});

}