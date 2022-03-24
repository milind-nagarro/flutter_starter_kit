import 'package:fab_nhl/crosscutting/channel/platform_channel.dart';
import 'package:flutter/material.dart';

class BlinkidOCR extends StatefulWidget {
  const BlinkidOCR({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BlinkidOCR> createState() => _BlinkidOCRState();
}

class _BlinkidOCRState extends State<BlinkidOCR> {
  final microblink = PlatformChannel();

  // bool isPhotoIDMatchInitiated = false;
  String ocrText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          microblink.getTextFromImage().then((value) {
                            setState(() {
                              ocrText = value;
                            });
                          });
                        },
                        child: const Text("Scan ID")),
                  ),
                  Visibility(child: Text(ocrText)),
                ],
              ))
            ],
          ),
        ));
  }
}
