import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/ticker.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final Ticker _ticker;
  static const int _initialValue = 1;

  StreamSubscription<int> _tickerSubscription;

  ProgressBloc({@required Ticker ticker})
      : _ticker = ticker,
        super(const ProgressInitial(_initialValue));

  @override
  Stream<ProgressState> mapEventToState(
    ProgressEvent event,
  ) async* {
    if (event is ProgressStarted) {
      yield* _mapProgressStartedToState(event);
    } else if (event is ProgressReset) {
      yield* _mapProgressResetToState(event);
    } else if (event is ProgressTicked) {
      yield* _mapProgressTickedToState(event);
    } else if (event is ProgressJumped) {
      yield* _mapProgressJumpedToState();
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<ProgressState> _mapProgressStartedToState(
      ProgressStarted start) async* {
    yield ProgressRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen(
          (duration) => add(
            ProgressTicked(duration: duration),
          ),
        );
  }

  Stream<ProgressState> _mapProgressResetToState(ProgressReset reset) async* {
    final value = reset.value;
    _tickerSubscription?.cancel();

    yield ProgressInitial(value);
    add(ProgressStarted(duration: value));
  }

  Stream<ProgressState> _mapProgressTickedToState(ProgressTicked tick) async* {
    yield tick.duration <= kProgressTime
        ? ProgressRunInProgress(tick.duration)
        : const ProgressRunComplete();
  }

  Stream<ProgressState> _mapProgressJumpedToState() async* {
    yield const ProgressRunComplete();
  }
}
