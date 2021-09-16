part of 'progress_bloc.dart';

abstract class ProgressState extends Equatable {
  final int duration;

  const ProgressState(this.duration);

  @override
  List<Object> get props => [duration];
}

class ProgressInitial extends ProgressState {
  const ProgressInitial(int duration) : super(duration);

  @override
  String toString() => 'ProgressInitial { duration: $duration }';
}

class ProgressRunInProgress extends ProgressState {
  const ProgressRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'ProgressRunInProgress { duration: $duration }';
}

class ProgressRunComplete extends ProgressState {
  const ProgressRunComplete() : super(0);
}
