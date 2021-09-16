part of 'welcome_cubit.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

class WelcomeLoaded extends WelcomeState {
  const WelcomeLoaded();
  @override
  List<Object> get props => [];
}

class WelcomeLoadSuccess extends WelcomeState {
  const WelcomeLoadSuccess();
  @override
  List<Object> get props => [];
}

class WelcomeLoadInProgress extends WelcomeState {
  const WelcomeLoadInProgress();
  @override
  List<Object> get props => [];
}

class WelcomeLoadFailure extends WelcomeState {
  final String error;
  const WelcomeLoadFailure({
    this.error,
  });
  @override
  List<Object> get props => [error];
}
