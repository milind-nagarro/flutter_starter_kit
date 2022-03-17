import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeValue> {
  RememberMeCubit() : super(const RememberMeValue(false));
  void toggleSelection() {
    emit(RememberMeValue(!state.userSelection));
  }
}
