part of 'email_validation_bloc.dart';

abstract class EmailValidationEvent extends Equatable {
  const EmailValidationEvent();
}

class OnEmailValidationStatusRequested extends EmailValidationEvent {
  @override
  List<Object?> get props => [];
}

class OnEmailValidationRequested extends EmailValidationEvent {
  @override
  List<Object?> get props => [];
}
