import 'package:hive/hive.dart';

part 'user_info_hive.g.dart';

@HiveType(typeId: 0)
class UserInfoHive {
  @HiveField(0)
  final String id;

  const UserInfoHive({
    required this.id,
  });
}
