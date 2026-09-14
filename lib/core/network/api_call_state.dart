enum ApiCallStatus {
  idle,
  loading,
  success,
  error,
}

class ApiCallState<T> {
  final ApiCallStatus status;

  final T? data;

  final String? message;

  const ApiCallState({
    required this.status,
    this.data,
    this.message,
  });

  // Initial state
  factory ApiCallState.idle() {
    return const ApiCallState(
      status: ApiCallStatus.idle,
    );
  }

  // API running
  factory ApiCallState.loading() {
    return const ApiCallState(
      status: ApiCallStatus.loading,
    );
  }

  // API success
  factory ApiCallState.success({
    T? data,
    String? message,
  }) {
    return ApiCallState<T>(
      status: ApiCallStatus.success,
      data: data,
      message: message,
    );
  }

  // API failed
  factory ApiCallState.error({
    String? message,
  }) {
    return ApiCallState<T>(
      status: ApiCallStatus.error,
      message: message,
    );
  }

  bool get isIdle =>
      status == ApiCallStatus.idle;

  bool get isLoading =>
      status == ApiCallStatus.loading;

  bool get isSuccess =>
      status == ApiCallStatus.success;

  bool get isError =>
      status == ApiCallStatus.error;
}