import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({String error = "Failed to fetch data"}) : super(error);
}

class GenericFailure extends Failure {
  const GenericFailure({String error = 'Some error occured'}) : super(error);
}
