sealed class Result<T> {
  const Result();
}

class Loading<T> extends Result<T> {
  const Loading();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
