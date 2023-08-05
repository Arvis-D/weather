import 'package:equatable/equatable.dart';

class DelayedResult<T> extends Equatable {
  final T? value;
  final Exception? exception;
  final bool loading;

  const DelayedResult.fromError(Exception e)
      : value = null,
        exception = e,
        loading = false;

  const DelayedResult.fromValue(this.value)
      : exception = null,
        loading = false;

  const DelayedResult.loading({this.value})
      : exception = null,
        loading = true;

  const DelayedResult.refresh(this.value)
      : exception = null,
        loading = true;

  bool get isSuccessful => value != null;

  bool get isError => exception != null;

  @override
  List<Object?> get props => [value, exception, loading];
}
