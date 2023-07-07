import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:text2spech_example/states/tts_state.dart';

class Text2SpeechController {
  static const double volume = 0.5;
  static const double pitch = 1.0;
  static const double rate = 0.5;

  final FlutterTts flutterTts;
  final ValueNotifier<TtsState> ttsState;

  const Text2SpeechController({required this.flutterTts, required this.ttsState});

  Future stop() async {
    final result = await flutterTts.stop();
    if (result == 1) ttsState.value = TtsState.paused;
  }

  Future pause() async {
    final result = await flutterTts.pause();
    if (result == 1) ttsState.value = TtsState.paused;
  }

  Future speak(ValueNotifier<String> newVoiceText) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (newVoiceText.value.isNotEmpty) {
      await flutterTts.speak(newVoiceText.value);
    }
  }
}
