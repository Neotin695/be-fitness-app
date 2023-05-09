part of 'music_player_cubit.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();

  @override
  List<Object> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {}

class PlayAudio extends MusicPlayerState {}

class PauseAudio extends MusicPlayerState {}

class ResumeAudio extends MusicPlayerState {}

class NextAudio extends MusicPlayerState {}

class PreviousAudio extends MusicPlayerState {}
