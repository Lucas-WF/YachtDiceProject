abstract class GameEvent {
  const GameEvent();
}

class BooleanInputEvent extends GameEvent {
  const BooleanInputEvent({required this.key, required this.value});

  final int key;
  final bool value;
}

class InputEvent extends GameEvent {
  const InputEvent({required this.key, required this.number});

  final String key;
  final int? number;
}

class NewTotalValueEvent extends GameEvent {
  const NewTotalValueEvent({required this.total});

  final int total;
}

class ActiveButtonEvent extends GameEvent {
  const ActiveButtonEvent({required this.isActive});

  final bool isActive;
}
