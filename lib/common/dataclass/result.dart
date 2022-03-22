import 'package:fab_nhl/common/dataclass/status.dart';

class Result<T> {
  final Status status;
  final T? data;
  final FailureDetails? failureDetails;
  final ErrorDetails? errorDetails;

  Result._(this.status, {this.data, this.failureDetails, this.errorDetails});

  static success<T>(T data) => Result._(Status.success, data: data);

  static failure<T>(int httpCode, Object? error) => Result<T>._(Status.failure,
      failureDetails: FailureDetails(httpCode, error));

  static error<T>(Exception exception) =>
      Result<T>._(Status.error, errorDetails: ErrorDetails(exception));
}

class FailureDetails {
  final int httpCode;
  final Object? error;

  FailureDetails(this.httpCode, this.error);
}

class ErrorDetails {
  final Exception exception;

  ErrorDetails(this.exception);
}
