import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_clone/providers/game_settings_provider.dart';

class WordleTitleBar extends StatelessWidget {
  const WordleTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WordAttemptsToggle(),
          Text(
            "Wordle by Sughosh",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          WordSizeToggle()
        ],
      ),
    );
  }
}

class WordSizeToggle extends ConsumerWidget {
  const WordSizeToggle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    void _updateWordSize() {
      var newWordSize = 5;
      if (gameSettings.wordsize == 4) newWordSize = 5;
      if (gameSettings.wordsize == 5) newWordSize = 6;
      if (gameSettings.wordsize == 6) newWordSize = 4;
      gameSettingsNotifier.updateWordsize(newWordSize);
    }

    return Container(
      child: OutlinedButton(
        child: Text(gameSettings.wordsize.toString()),
        onPressed: _updateWordSize,
      ),
      margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
    );
  }
}

class WordAttemptsToggle extends ConsumerWidget {
  const WordAttemptsToggle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    void _updateAttempts() {
      var newAttempts = 6;
      if (gameSettings.attempts == 4) newAttempts = 5;
      if (gameSettings.attempts == 5) newAttempts = 6;
      if (gameSettings.attempts == 6) newAttempts = 4;
      gameSettingsNotifier.updateAttempts(newAttempts);
    }

    String text;
    switch (gameSettings.attempts) {
      case 4:
        text = "High";
        break;
      case 5:
        text = "Med";
        break;
      case 6:
      default:
        text = "Low";
        break;
    }

    return Container(
      child: OutlinedButton(
        child: Text(text),
        onPressed: _updateAttempts,
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
    );
  }
}
