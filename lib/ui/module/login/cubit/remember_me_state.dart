part of 'remember_me_cubit.dart';

abstract class RememberMeState extends Equatable {
  const RememberMeState();

  @override
  List<Object> get props => [];
}

class RememberMeValue extends RememberMeState {
  const RememberMeValue(this.userSelection) : super();
  final bool userSelection;
  @override
  List<Object> get props => [userSelection];
}
