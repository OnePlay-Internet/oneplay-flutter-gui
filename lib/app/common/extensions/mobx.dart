import 'package:mobx/mobx.dart';

extension MobxStream<T> on Stream<T> {
  ObservableStream<T> toMobxStream() => ObservableStream<T>(this);
}

extension MobxFuture<T> on Future<T> {
  ObservableFuture<T> toMobxFuture() => ObservableFuture<T>(this);
}
