import 'package:hive_flutter/adapters.dart';

part 'locker_condition.g.dart';

@HiveType(typeId: 2)
class LockerCondition {
  const LockerCondition(this.isGoodCondition, {this.comments, this.problems});

  @HiveField(0)
  final bool isGoodCondition;
  @HiveField(1)
  final String? comments;
  @HiveField(2)
  final String? problems;

  factory LockerCondition.isGood({String? comments}) {
    return LockerCondition(true, comments: comments);
  }

  LockerCondition copyWith({
    bool? isGoodCondition,
    String? comments,
    String? problems,
  }) {
    return LockerCondition(
      isGoodCondition ?? this.isGoodCondition,
      comments: comments ?? this.comments,
      problems: problems ?? this.problems,
    );
  }
}
