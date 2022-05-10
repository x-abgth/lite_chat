part of 'email_validation_bloc.dart';

abstract class EmailValidationState extends Equatable {
  const EmailValidationState();
}

class InitialEmailValidationState extends EmailValidationState {
  @override
  List<Object?> get props => [];
}

class EmailNotVerified extends EmailValidationState {
  @override
  List<Object?> get props => [];
}

class EmailVerified extends EmailValidationState {
  @override
  List<Object?> get props => [];
}

class EmailVerificationError extends EmailValidationState {
  final String error;

  EmailVerificationError(this.error);
  @override
  List<Object?> get props => [error];
}
