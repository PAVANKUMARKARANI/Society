class ProfileState {
  final List<String> topFriends;
  final String? societyLink;
  final List<String> workDetails;
  final String? mood;
  final String? relationshipStatus;

  const ProfileState({
    this.topFriends = const [],
    this.societyLink,
    this.workDetails = const [],
    this.mood,
    this.relationshipStatus,
  });

  ProfileState copyWith({
    List<String>? topFriends,
    String? societyLink,
    List<String>? workDetails,
    String? mood,
    String? relationshipStatus,
  }) {
    return ProfileState(
      topFriends: topFriends ?? this.topFriends,
      societyLink: societyLink ?? this.societyLink,
      workDetails: workDetails ?? this.workDetails,
      mood: mood ?? this.mood,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
    );
  }
}
