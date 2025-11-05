class LockerCondition {
  const LockerCondition(this.isGoodCondition, {this.comments, this.problems});

  final bool isGoodCondition;
  final String? comments;
  final String? problems;

  factory LockerCondition.isGood({String? comments}) {
    return LockerCondition(true, comments: comments);
  }

  Map<String, dynamic> toJson() => {
    'isGood': isGoodCondition,
    'comments': comments,
    'problems': problems,
  };

  factory LockerCondition.fromJson(Map<String, dynamic> json) {
    return LockerCondition(json['isGood']);
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
