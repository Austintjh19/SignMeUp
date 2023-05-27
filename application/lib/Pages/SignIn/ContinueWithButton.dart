import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Images/ImageServicing.dart';

class ContinueWithButton extends StatelessWidget {
  final String iconPath;
  final String description;
  final Function function;
  const ContinueWithButton(
      {super.key,
      required this.iconPath,
      required this.description,
      required this.function});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed: () {
        function();
      },
      icon: Image.asset(
        iconPath,
        height: 30,
        width: 30,
      ),
      label: AutoSizeText(
        description,
        style: const TextStyle(
            fontFamily: 'Raleway', color: Color.fromRGBO(42, 42, 42, 1)),
        minFontSize: 8,
        maxFontSize: 16,
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 75),
        minimumSize: const Size.fromHeight(30),
        shadowColor: Colors.black,
        elevation: 20,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    // return FutureBuilder(
    //     future: ImageServicing().getImageURL(iconPath),
    //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done &&
    //           snapshot.hasData) {
    //         return ElevatedButton.icon(
    //           onPressed: () {
    //             function();
    //           },
    //           icon: Image.network(snapshot.data!, height: 30, width: 30),
    //           label: AutoSizeText(
    //             description,
    //             style: const TextStyle(
    //                 fontFamily: 'Raleway',
    //                 color: Color.fromRGBO(42, 42, 42, 1)),
    //             minFontSize: 8,
    //             maxFontSize: 16,
    //           ),
    //           style: ElevatedButton.styleFrom(
    //             padding:
    //                 const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //             minimumSize: const Size.fromHeight(30),
    //             shadowColor: Colors.black,
    //             elevation: 20,
    //             backgroundColor: Colors.white,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(20)),
    //           ),
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting ||
    //           !snapshot.hasData) {
    //         return CircularProgressIndicator();
    //       }
    //       return Container();
    //     });
  }
}
