import 'package:hive/hive.dart';

part 'visite.g.dart';

@HiveType(typeId: 0)
class Visite {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int patient;

  @HiveField(2)
  final String datePrevue;

  @HiveField(3)
  final int duree;

  Visite({
    required this.id,
    required this.patient,
    required this.datePrevue,
    required this.duree,
  });
}
