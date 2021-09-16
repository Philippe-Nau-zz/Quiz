part of 'progress_bloc.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object> get props => [];
}

class ProgressStarted extends ProgressEvent {
  const ProgressStarted({@required this.duration});
  final int duration;
}

class ProgressPaused extends ProgressEvent {
  const ProgressPaused();
}

class ProgressResumed extends ProgressEvent {
  const ProgressResumed();
}

class ProgressReset extends ProgressEvent {
  final int value;
  const ProgressReset(this.value);

  @override
  List<Object> get props => [value];
}

class ProgressJumped extends ProgressEvent {
  const ProgressJumped();
}

class ProgressTicked extends ProgressEvent {
  const ProgressTicked({@required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
