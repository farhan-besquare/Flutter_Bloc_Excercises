import 'package:flutter_bloc/flutter_bloc.dart';

class BlocInputCubit extends Cubit<String> {
  BlocInputCubit() : super("");

  void capitalise(word) {
    emit(word.toUpperCase());
  }
}
