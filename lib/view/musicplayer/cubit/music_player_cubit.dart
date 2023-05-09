import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'music_player_state.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  static MusicPlayerCubit get(context) => BlocProvider.of(context);
  MusicPlayerCubit() : super(MusicPlayerInitial());
  final player = AudioPlayer();

  Duration audioDuration = const Duration();
  Duration audioPosition = const Duration();

  Future<void> setAudioUrl(audioUrl) async {
    audioDuration = await player.setUrl(audioUrl) ?? const Duration();
  }
}
