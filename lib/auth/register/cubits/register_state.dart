abstract class RegisterState {}

class RegisterIntinalState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String errorMessage;
  RegisterFailureState({required this.errorMessage});
}
