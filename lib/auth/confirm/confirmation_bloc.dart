import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_cubit.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/auth/confirm/confirmation_event.dart';
import 'package:test12021summer_jiyeyu/auth/confirm/confirmation_state.dart';
import 'package:test12021summer_jiyeyu/auth/form_submission_status.dart';


class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState>
{
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    this.authRepo,
    this.authCubit}): super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async*{
    // TODO: implement mapEventToState

    //Confirmation code updated
    if(event is ConfirmationCodeChanged)
    {
      yield state.copyWith(code: event.code);
    }


    //Form submitted
    else if (event is ConfirmationSubmitted)
    {
      yield state.copyWith(formStatus: FormSubmitting());

      try
      {
        final userId = await authRepo.confirmSingUp(
            username: authCubit.credentials.username,
            confirmationCode: state.code,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        credentials.userId = userId;

        authCubit.launchSession(credentials);
      }
      catch(e)
      {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}