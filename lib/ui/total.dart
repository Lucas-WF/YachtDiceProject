import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yatch_project/ui/theme/design_system.dart';

class TotalPage extends StatelessWidget {
  const TotalPage({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image
                Image.asset("assets/multipointed_star.png"),

                // Column with text elements
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Pontuação final",
                        style: TextStyle(
                            color: YachtDiceColors.white, fontSize: 16),
                      ),
                    ),
                    Text(
                      total.toString(),
                      style: const TextStyle(
                          color: YachtDiceColors.white, fontSize: 56),
                    ),
                  ],
                ),

                // TextButton below the image
                Positioned(
                  bottom: 40, // Adjust the bottom value as needed
                  child: SizedBox(
                    height: size.height * 0.06,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: YachtDiceColors.green,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        onPressed: () {
                          context.go("/");
                        },
                        child: const Text(
                          "Novo Jogo",
                          style: TextStyle(
                              color: YachtDiceColors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
