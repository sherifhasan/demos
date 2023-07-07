import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:text2spech_example/controllers/text2speech_controller.dart';
import 'package:text2spech_example/states/tts_state.dart';
import 'package:text2spech_example/widgets/control_button.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newVoiceText = useState('');
    final controller = Text2SpeechController(ttsState: useState(TtsState.stopped), flutterTts: FlutterTts());
    useEffect(() {
      Future.microtask(() async {
        await controller.flutterTts.awaitSpeakCompletion(true);
      });

      controller.flutterTts.setStartHandler(() {
        debugPrint("Playing");
        controller.ttsState.value = TtsState.playing;
      });

      if (!kIsWeb && Platform.isAndroid) {
        controller.flutterTts.setInitHandler(() {
          debugPrint("TTS Initialized");
        });
      }

      controller.flutterTts.setCompletionHandler(() {
        debugPrint("Complete");
        controller.ttsState.value = TtsState.stopped;
      });

      controller.flutterTts.setCancelHandler(() {
        debugPrint("Cancel");
        controller.ttsState.value = TtsState.stopped;
      });

      controller.flutterTts.setPauseHandler(() {
        debugPrint("Paused");
        controller.ttsState.value = TtsState.paused;
      });

      controller.flutterTts.setContinueHandler(() {
        debugPrint("Continued");
        controller.ttsState.value = TtsState.continued;
      });

      controller.flutterTts.setErrorHandler((msg) {
        debugPrint("error: $msg");
        controller.ttsState.value = TtsState.stopped;
      });
      return null;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text2Speech Sample'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.blue)),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Speech text',
                  ),
                  maxLines: 11,
                  minLines: 6,
                  onChanged: (String value) {
                    newVoiceText.value = value;
                  },
                )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.blueGrey)),
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildControlButton(
                    color: Colors.green,
                    splashColor: Colors.greenAccent,
                    icon: Icons.play_arrow,
                    label: 'PLAY',
                    func: () => controller.speak(newVoiceText),
                  ),
                  BuildControlButton(
                    color: Colors.red,
                    splashColor: Colors.redAccent,
                    icon: Icons.stop,
                    label: 'STOP',
                    func: () => controller.stop(),
                  ),
                  BuildControlButton(
                    color: Colors.blue,
                    splashColor: Colors.blueAccent,
                    icon: Icons.pause,
                    label: 'PAUSE',
                    func: () => () => controller.pause(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
