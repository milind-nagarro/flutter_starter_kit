part of 'verifypin_cubit.dart';

abstract class VerifypinState extends Equatable {
  const VerifypinState();

  @override
  List<Object> get props => [];
}

class VerifypinInitial extends VerifypinState {
  final String pin;
  final ValidationState isValid;
  final bool? isVerified;
  final bool maxRetriesAttempted;
  const VerifypinInitial(
      {this.pin = "",
      this.isValid = ValidationState.notChecked,
      this.isVerified,
      this.maxRetriesAttempted = false});
  @override
  List<Object> get props => [pin, isValid, maxRetriesAttempted];
}
