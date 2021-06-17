import 'dart:io';

import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final route;
  final nextRoute;

  Buttons({Key? key, this.route, this.nextRoute});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              skipClip(context, nextRoute),
              const SizedBox(
                width: 7,
              ),
              SettingsClip(route: route),
            ],
          ),
        );
      } else {
        return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              skipClip(context, nextRoute),
              const SizedBox(
                width: 7,
              ),
              SettingsClip(route: route),
            ],
          ),
        );
      }
    });
  }
}

class SettingsClip extends StatelessWidget {
  final route;

  SettingsClip({Key? key, this.route});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
          // todo: add settings (page)
          // onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => Settings(
          //                 route: route,
          //               )),
          //     ),
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/images/gui/more.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
    });
  }
}

dynamic skipClip(context, nextRoute) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () => showAlertDialog(context, nextRoute),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      "assets/images/gui/fastforwardhover.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

showAlertDialog(BuildContext context, nextRoute) {
  Widget continueButton = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Theme.of(context).primaryColor),
        child: const Text(
          "YES",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Aleo",
              fontSize: 22,
              letterSpacing: .4),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(nextRoute);
        },
      ),
      const SizedBox(
        width: 10,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Theme.of(context).primaryColor),
        child: const Text(
          "NO",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Aleo",
              fontSize: 22,
              letterSpacing: .4),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  Dialog alert = Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.all(10),
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.amberAccent),
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: <Widget>[
          const Text("Chapter Skip",
              style: TextStyle(fontSize: 28, fontFamily: "Aleo"),
              textAlign: TextAlign.center),
          const Text("Are you sure about that?",
              style: TextStyle(fontSize: 24, fontFamily: "Aleo"),
              textAlign: TextAlign.center),
          const Spacer(),
          continueButton,
        ],
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}