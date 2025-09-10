class LockerCondition {
  const LockerCondition({this.isGoodCondition = true, this.comments});

  final bool isGoodCondition;
  final String? comments;

  LockerCondition copyWith({bool? isGoodCondition, String? comments}) {
    return LockerCondition(
      isGoodCondition: isGoodCondition ?? this.isGoodCondition,
      comments: comments ?? this.comments,
    );
  }
}
