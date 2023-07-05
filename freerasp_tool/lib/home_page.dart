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
        final base64Hash = hashConverter.fromSha256toBase64(
            '6F:B1:3E:85:9E:B8:4E:18:BE:50:A4:50:E6:A7:7E:8B:F1:FB:44:A2:E5:AD:9A:6D:E0:FB:1D:60:1A:88:F7:6B');
        final config = TalsecConfig(
          /// For Android
          androidConfig: AndroidConfig(
            signingCertHashes: [base64Hash],
            packageName: 'com.example.freerasp_tool',
          ),

          /// For iOS
          iosConfig: IOSConfig(
            bundleIds: ['com.demos.freerasp_tool'],
            teamId: 'D2A8ZV8F9B',
          ),
          watcherMail: 'sherif.hasan1994@gmail.com',
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
