part of 'verifypin_cubit.dart';

abstract class VerifypinState extends Equatable {
  const VerifypinState();

  @override
  List<Object> get props => [];
}

class VerifypinInitial extends VerifypinState {
  final String pin;
  final bool isValid;
  final bool? isVerified;
  const VerifypinInitial(
      {this.pin = "", this.isValid = false, this.isVerified});
  @override
  List<Object> get props => [pin, isValid];
}
