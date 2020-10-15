import 'package:bloc/bloc.dart';

enum CounterEvent { INCREMENT, DECREMENT }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  // https://stackoverflow.com/questions/55397023/whats-the-difference-between-async-and-async-in-dart#:~:text=2%20Answers&text=Marking%20a%20function%20as%20async,a%20value%20through%20yield%20keyword.
  // https://dart.dev/guides/language/language-tour#generators
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.INCREMENT:
        yield state + 1;
        break;
      case CounterEvent.DECREMENT:
        yield state - 1;
        break;
      default:
        yield state;
    }
  }
}

main(List<String> args) async {
  final counterBloc = CounterBloc();

  // demonstrate bloc is a Stream with
  // EVENT as trigger & output the state

  final counterBlocSub = counterBloc.listen(print);

  counterBloc.add(CounterEvent.INCREMENT);
  counterBloc.add(CounterEvent.DECREMENT);
  counterBloc.add(CounterEvent.INCREMENT);
  counterBloc.add(CounterEvent.INCREMENT);
  counterBloc.add(CounterEvent.INCREMENT);

  await Future.delayed(Duration.zero);

  await counterBlocSub.cancel();
  await counterBloc.close();
}
