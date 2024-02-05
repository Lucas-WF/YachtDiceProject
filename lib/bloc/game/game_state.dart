import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState(
      {this.gameList = const {},
      this.specialList = const [false, false, false, false],
      this.isActive = false,
      this.total = 0,
      this.hasBonus = false,
      this.endGameTotal = 0});

  final Map<String, int?> gameList;
  final List<bool> specialList;
  final bool isActive;
  final int total;
  final bool hasBonus;
  final int endGameTotal;

  @override
  List<Object?> get props =>
      [gameList, specialList, isActive, total, hasBonus, endGameTotal];
}

class InitialState extends GameState {
  const InitialState({
    super.gameList,
    super.specialList,
    super.isActive,
    super.total,
    super.hasBonus,
    super.endGameTotal,
  });
}

class GameMapState extends GameState {
  const GameMapState({
    super.gameList,
    super.specialList,
    super.isActive,
    super.total,
    super.hasBonus,
    super.endGameTotal,
  });

  GameMapState copyWith(
    Map<String, int?>? gameList,
    List<bool>? specialList,
    bool? isActive,
    int? total,
    bool? hasBonus,
    int? endGameTotal,
  ) {
    return GameMapState(
      gameList: gameList ?? super.gameList,
      specialList: specialList ?? super.specialList,
      isActive: isActive ?? super.isActive,
      total: total ?? super.total,
      hasBonus: hasBonus ?? super.hasBonus,
      endGameTotal: endGameTotal ?? super.endGameTotal,
    );
  }
}

class SpecialMapState extends GameState {
  const SpecialMapState({
    super.gameList,
    super.specialList,
    super.isActive,
    super.total,
    super.hasBonus,
    super.endGameTotal,
  });

  SpecialMapState copyWith(
    Map<String, int?>? gameList,
    List<bool>? specialList,
    bool? isActive,
    int? total,
    bool? hasBonus,
    int? endGameTotal,
  ) {
    return SpecialMapState(
      gameList: gameList ?? super.gameList,
      specialList: specialList ?? super.specialList,
      isActive: isActive ?? super.isActive,
      total: total ?? super.total,
      hasBonus: hasBonus ?? super.hasBonus,
      endGameTotal: endGameTotal ?? super.endGameTotal,
    );
  }
}

class ActiveButtonState extends GameState {
  const ActiveButtonState({
    super.gameList,
    super.specialList,
    super.isActive,
    super.total,
    super.hasBonus,
    super.endGameTotal,
  });

  ActiveButtonState copyWith(
    Map<String, int?>? gameList,
    List<bool>? specialList,
    bool? isActive,
    int? total,
    bool? hasBonus,
    int? endGameTotal,
  ) {
    return ActiveButtonState(
      specialList: specialList ?? super.specialList,
      gameList: gameList ?? super.gameList,
      isActive: isActive ?? super.isActive,
      total: total ?? super.total,
      hasBonus: hasBonus ?? super.hasBonus,
      endGameTotal: endGameTotal ?? super.endGameTotal,
    );
  }
}

class NewTotalValueState extends GameState {
  const NewTotalValueState({
    super.total,
    super.specialList,
    super.gameList,
    super.isActive,
    super.hasBonus,
    super.endGameTotal,
  });

  NewTotalValueState copyWith(
    Map<String, int?>? gameList,
    List<bool>? specialList,
    bool? isActive,
    int? total,
    bool? hasBonus,
    int? endGameTotal,
  ) {
    return NewTotalValueState(
      specialList: specialList ?? super.specialList,
      gameList: gameList ?? super.gameList,
      isActive: isActive ?? super.isActive,
      total: total ?? super.total,
      hasBonus: hasBonus ?? super.hasBonus,
      endGameTotal: endGameTotal ?? super.endGameTotal,
    );
  }
}
