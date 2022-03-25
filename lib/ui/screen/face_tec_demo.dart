import 'package:fab_nhl/crosscutting/channel/platform_channel.dart';
import 'package:flutter/material.dart';

class FacetecLiveness extends StatefulWidget {
  const FacetecLiveness({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FacetecLiveness> createState() => _FacetecLivenessState();
}

class _FacetecLivenessState extends State<FacetecLiveness> {
  final faceTec = PlatformChannel();

  bool isPhotoIDMatchInitiated = false;
  bool isPhotoIDMatchSuccessful = false;

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
                          isPhotoIDMatchInitiated = true;
                          faceTec.checkLiveness().then((value) {
                            setState(() {
                              isPhotoIDMatchSuccessful = value;
                            });
                          });
                        },
                        child: const Text("Liveness check")),
                  ),
                  Visibility(
                      visible: isPhotoIDMatchInitiated,
                      child: Text("Successful?: $isPhotoIDMatchSuccessful")),
                ],
              ))
            ],
          ),
        ));
  }
}
