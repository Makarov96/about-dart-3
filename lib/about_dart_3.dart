import 'dart:async';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  final bloc = BlocManagement();

  await bloc.prompt(message: 'Hello friend');

  BlocListener(
    bloc: bloc.stream,
    builder: (state) {
      final stateResult = switch (state) {
        Initial() => 'Initial',
        Loading() => 'Loading',
        Loaded(data: var data) => data,
        ErrorState() => 'Error',
      };

      print(stateResult);
    },
  );

  final either = await result();
  either.fold(
    (r) => print(r),
    (isLoading) => print(isLoading),
    (l) => print(l),
  );
}

Future<Either<String, String>> result() async {
  try {
    await Future.delayed(Duration(milliseconds: 300));
    return Right(data: 'Hello from backend');
  } catch (e) {
    return Left(error: e.toString());
  }
}

typedef Fold<T> = T Function(T);

sealed class Either<L, R> {
  const Either();

  B fold<B>(
    B Function(R r) right,
    B Function(bool loading) isLoading,
    B Function(L l) left,
  );
}

class Right<L, R> extends Either<L, R> {
  const Right({
    required this.data,
  });
  final R data;

  @override
  B fold<B>(
    B Function(R r) right,
    B Function(bool loading) isLoading,
    B Function(L l) left,
  ) {
    return right(data);
  }
}

class Left<L, R> extends Either<L, R> {
  const Left({required this.error});
  final L error;

  @override
  B fold<B>(
    B Function(R r) right,
    B Function(bool loading) isLoading,
    B Function(L l) left,
  ) {
    return left(error);
  }
}

typedef Builder<T> = Function(T state);

class BlocListener<T> {
  BlocListener({
    required this.bloc,
    required this.builder,
  }) {
    init();
  }
  final Stream<T> bloc;
  late StreamSubscription<T>? _subscription;
  final Builder<T> builder;

  void init() {
    _subscription = bloc.listen(
      (state) => builder(state),
    );

    _subscription?.onDone(() {
      close();
    });
  }

  void close() {
    _subscription?.cancel();
    _subscription = null;
  }
}

class BlocManagement {
  BlocManagement() {
    _stateController.add(Initial());
  }

  final StreamController<State> _stateController = StreamController();
  Stream<State> get stream => _stateController.stream;

  Future<void> prompt({required message}) async {
    try {
      _stateController.add(Loading());

      _stateController.add(Loaded(data: 'Value from Backend'));
    } catch (e) {
      _stateController.add(ErrorState(message: e.toString(), preffix: '0'));
    }
  }

  void close() {
    _stateController.close();
  }
}

sealed class State {
  const State();
}

class Initial extends State {
  const Initial();
}

class Loading extends State {
  const Loading();
}

class Loaded extends State {
  const Loaded({
    required this.data,
  });
  final String data;
}

class ErrorState extends State {
  const ErrorState({
    required this.message,
    required this.preffix,
  });

  final String message;
  final String preffix;
}
