import 'package:bloc_demo/bloc/res_bloc/res_event.dart';
import 'package:bloc_demo/bloc/res_bloc/res_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/joke_repository.dart';


class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final JokeRepository _jokeRepository;

  JokeBloc(this._jokeRepository) : super(JokeLoadingState()) {
    on<LoadJokeEvent>((event, emit) async {
      emit(JokeLoadingState());
      try {
        final joke = await _jokeRepository.getJoke();
        emit(JokeLoadedState(joke));
      } catch (e) {
        emit(JokeErrorState(e.toString()));
      }
    });
  }
}