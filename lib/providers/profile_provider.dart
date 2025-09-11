import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;
import '../models/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
    : super(const ProfileState(societyLink: "https://society.so/vikash27459"));

  void updateTopFriends(List<String> friends) {
    state = state.copyWith(topFriends: friends);
  }

  void updateMood(String mood) {
    state = state.copyWith(mood: mood);
  }

  void updateRelationshipStatus(String status) {
    state = state.copyWith(relationshipStatus: status);
  }

  void updateWorkDetails(List<String> workDetails) {
    state = state.copyWith(workDetails: workDetails);
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier();
});
