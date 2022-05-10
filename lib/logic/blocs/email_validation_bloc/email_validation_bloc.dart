import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/firebase_auth_repository.dart';

part 'email_validation_event.dart';
part 'email_validation_state.dart';

class EmailValidationBloc
    extends Bloc<EmailValidationEvent, EmailValidationState> {
  final FirebaseAuthRepository firebaseAuthRepository;

  EmailValidationBloc({required this.firebaseAuthRepository})
      : super(InitialEmailValidationState()) {
    on<OnEmailValidationStatusRequested>((event, emit) async {
      try {
        final bool isVerified =
            await firebaseAuthRepository.checkEmailVerified();
        if (!isVerified) {
          emit(EmailNotVerified());
        } else {
          emit(EmailVerified());
        }
      } catch (e) {
        emit(EmailVerificationError(e.toString()));
        emit(EmailNotVerified());
      }
    });

    on<OnEmailValidationRequested>((event, emit) async {
      emit(EmailNotVerified());
      try {
        await firebaseAuthRepository.sendVerificationEmail();
      } catch (e) {
        emit(EmailVerificationError(e.toString()));
        emit(EmailNotVerified());
      }
    });
  }
}
