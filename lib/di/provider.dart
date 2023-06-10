class Provider<T> {
  T? _obj;
  final T Function() _create;

  Provider(this._create);

  T get() {
    _obj ??= _create();
    return _obj!;
  }
}
