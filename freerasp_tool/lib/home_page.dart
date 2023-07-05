import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freerasp/freerasp.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final threatState = useState('');
    useEffect(() {
      Future.microtask(() async {
        /// add your key hash
        final base64Hash = hashConverter.fromSha256toBase64(
            '');
        final config = TalsecConfig(
          /// For Android
          androidConfig: AndroidConfig(
            signingCertHashes: [base64Hash],
            packageName: 'com.example.freerasp_tool',
          ),

          /// For iOS
          /// teamid and watcher to send threat report to it
          iosConfig: IOSConfig(
            bundleIds: ['com.demos.freerasp_tool'],
            teamId: '',
          ),
          watcherMail: '',
        );
        await Talsec.instance.start(config);
        Talsec.instance.onThreatDetected.listen((threat) {
          threatState.value = 'Threat detected: $threat';
        });
      });

      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('FreeRASP sample'),
      ),
      body: Center(
          child: Text(
        threatState.value,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      )),
    );
  }
}
