import 'package:hive/hive.dart';

part 'credentials.g.dart';

@HiveType(typeId: 1)
class Credentials {
  @HiveField(0)
  final String login;

  @HiveField(1)
  final String passwordHash;

  Credentials({required this.login, required this.passwordHash});
}
