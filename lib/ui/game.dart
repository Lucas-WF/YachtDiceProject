import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yatch_project/bloc/game/game_bloc.dart';
import 'package:yatch_project/bloc/game/game_event.dart';
import 'package:yatch_project/bloc/game/game_state.dart';
import 'package:yatch_project/repository/game_repository.dart';
import 'package:yatch_project/ui/theme/design_system.dart';
import 'package:yatch_project/ui/widgets/yacht_text_form_field.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> types = {
      "Aces": 5,
      "Twos": 10,
      "Threes": 15,
      "Fours": 20,
      "Fives": 25,
      "Sixes": 30,
      "Chances": 30,
      "4 of a kind": 30
    };
    List<String> otherTypes = [
      "Full House",
      "Sml straight",
      "Long straight",
      "Yacht"
    ];
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => GameRepository(),
      child: BlocProvider(
        create: (context) =>
            GameBloc(repository: context.read<GameRepository>()),
        child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  "Yacht Dice",
                  style: TextStyle(color: YachtDiceColors.blue),
                ),
                centerTitle: true,
                backgroundColor: YachtDiceColors.titleBg,
                scrolledUnderElevation: 0,
              ),
              body: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          height: size.height * 0.39,
                          width: size.width,
                          decoration: const BoxDecoration(
                              color: YachtDiceColors.blueGrey,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 24, left: 24, top: 16),
                            child: Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: types.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: SizedBox(
                                              height: size.height * 0.032,
                                              width: size.width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      types.keys
                                                          .toList()[index],
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                  Flexible(
                                                    child: YachtTextFormField(
                                                      onFieldSubmitted: (text) {
                                                        context
                                                            .read<GameBloc>()
                                                            .add(InputEvent(
                                                                key: types.keys
                                                                        .toList()[
                                                                    index],
                                                                number: text
                                                                        .isEmpty
                                                                    ? null
                                                                    : int.parse(
                                                                        text)));
                                                      },
                                                      width: size.width * 0.156,
                                                      height:
                                                          size.height * 0.032,
                                                      maxValue: types[types.keys
                                                          .toList()[index]],
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                          color: YachtDiceColors
                                                              .grey,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                          color: YachtDiceColors
                                                              .blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                            height: state.hasBonus
                                ? size.height * 0.096
                                : size.height * 0.075,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: YachtDiceColors.blueGrey,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(16))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Builder(builder: (context) {
                                      if (state.hasBonus) {
                                        return Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              YachtTextFormField(
                                                controller:
                                                    TextEditingController(
                                                        text: state.total
                                                            .toString()),
                                                isReadOnly: true,
                                                width: size.width * 0.156,
                                                height: size.height * 0.032,
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide(
                                                    color: YachtDiceColors.grey,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide(
                                                    color: YachtDiceColors.grey,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Bônus +35",
                                                style: TextStyle(
                                                    color:
                                                        YachtDiceColors.green,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return Flexible(
                                        child: YachtTextFormField(
                                          controller: TextEditingController(
                                              text: state.total.toString()),
                                          isReadOnly: true,
                                          width: size.width * 0.156,
                                          height: size.height * 0.032,
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                              color: YachtDiceColors.grey,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                              color: YachtDiceColors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ]),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Container(
                          height: size.height * 0.23,
                          width: size.width,
                          decoration: const BoxDecoration(
                              color: YachtDiceColors.blueGrey,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 16),
                            child: Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: otherTypes.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: size.height * 0.045,
                                            width: size.width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(otherTypes[index],
                                                    style: const TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(
                                                  width: size.width * 0.156,
                                                  child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Switch(
                                                        activeTrackColor:
                                                            Colors.white,
                                                        inactiveTrackColor:
                                                            YachtDiceColors
                                                                .white,
                                                        inactiveThumbColor:
                                                            YachtDiceColors
                                                                .grey,
                                                        trackOutlineColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .transparent),
                                                        value: state
                                                            .specialList[index],
                                                        activeColor:
                                                            YachtDiceColors
                                                                .green,
                                                        onChanged: (value) {
                                                          context
                                                              .read<GameBloc>()
                                                              .add(BooleanInputEvent(
                                                                  key: index,
                                                                  value: !state
                                                                          .specialList[
                                                                      index]));
                                                        }),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        })),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        width: size.width,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              disabledBackgroundColor: YachtDiceColors.grey,
                              backgroundColor: YachtDiceColors.green,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: state.isActive
                              ? () {
                                  context.go("/total",
                                      extra: state.endGameTotal);
                                }
                              : null,
                          child: const Text(
                            "Finalizar Partida",
                            style: TextStyle(
                                color: YachtDiceColors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
