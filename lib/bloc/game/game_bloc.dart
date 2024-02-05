import 'package:yatch_project/bloc/game/game_event.dart';
import 'package:yatch_project/bloc/game/game_state.dart';
import 'package:bloc/bloc.dart';
import 'package:yatch_project/repository/game_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.repository}) : super(const InitialState()) {
    on<InputEvent>(_onTextInputReceived);
    on<BooleanInputEvent>(_onBooleanInputReceived);
    on<ActiveButtonEvent>(_onActiveButton);
    on<NewTotalValueEvent>(_onNewTotal);
  }

  final GameRepository repository;

  void _onTextInputReceived(InputEvent event, Emitter emit) {
    repository.values[event.key] = event.number;

    add(NewTotalValueEvent(total: repository.normalValuesSum()));

    if (repository.values.values.nonNulls.length < 8) {
      add(const ActiveButtonEvent(isActive: false));
    } else {
      add(const ActiveButtonEvent(isActive: true));
    }
    emit(
      GameMapState(
        gameList: Map<String, int?>.from(repository.values),
        specialList: state.specialList,
        isActive: state.isActive,
        total: state.total,
        hasBonus: repository.bonus > 0 ? true : false,
        endGameTotal: repository.totalSum(),
      ),
    );
  }

  void _onBooleanInputReceived(BooleanInputEvent event, Emitter emit) {
    repository.specialValues[event.key] = event.value;
    emit(
      SpecialMapState(
        gameList: state.gameList,
        specialList: List.from(repository.specialValues),
        isActive: state.isActive,
        total: state.total,
        hasBonus: state.hasBonus,
        endGameTotal: repository.totalSum(),
      ),
    );
  }

  void _onActiveButton(ActiveButtonEvent event, Emitter emit) {
    emit(
      ActiveButtonState(
        specialList: state.specialList,
        gameList: state.gameList,
        isActive: event.isActive,
        total: state.total,
        hasBonus: state.hasBonus,
        endGameTotal: state.endGameTotal,
      ),
    );
  }

  void _onNewTotal(NewTotalValueEvent event, Emitter emit) {
    emit(
      NewTotalValueState(
        specialList: state.specialList,
        gameList: state.gameList,
        isActive: state.isActive,
        total: event.total,
        hasBonus: state.hasBonus,
        endGameTotal: state.endGameTotal,
      ),
    );
  }
}
