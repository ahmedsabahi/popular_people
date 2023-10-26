import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

// General failures
class BadRequestFailure extends Failure {
  const BadRequestFailure({String? message}) : super(message ?? 'Bad Request');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String? message})
      : super(message ?? 'Unauthorized');
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({String? message}) : super(message ?? 'Forbidden');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message}) : super(message ?? 'Not Found');
}

class ConflictFailure extends Failure {
  const ConflictFailure({String? message}) : super(message ?? 'Conflict');
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure({String? message})
      : super(message ?? 'Internal Server Error');
}

class DeadlineExceededFailure extends Failure {
  const DeadlineExceededFailure({String? message})
      : super(message ?? 'Deadline Exceeded');
}

class InvalidAccessTokenFailure extends Failure {
  const InvalidAccessTokenFailure({String? message})
      : super(message ?? 'Invalid Access Token');
}

class OtherFailure extends Failure {
  const OtherFailure({String? message}) : super(message ?? 'Other');
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({String? message}) : super(message ?? 'No Internet');
}

class NoPermissionFailure extends Failure {
  const NoPermissionFailure({String? message})
      : super(message ?? 'No Permission');
}
