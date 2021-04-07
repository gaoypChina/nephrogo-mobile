extension GeneralExtensions<T> on T {
  R let<R>(R Function(T v) func) => func(this);
}
