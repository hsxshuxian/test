import 'package:bloc/bloc.dart';
import 'package:flutter_ios_channel/block/test_event.dart';
import 'package:flutter_ios_channel/block/test_state.dart';
import 'package:formz/formz.dart';

import '../models/email.dart';
import '../models/password.dart';
import 'my_form_bloc.dart';

class TestBlock extends Bloc<TestEvent, TestState>{

  TestBlock() : super(const TestState()) {
   on<TestEmailChanged>(_onEmailChanged);
  }

  @override
  void onTransition(Transition<TestEvent, TestState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  ////修改email
  void _onEmailChanged(TestEmailChanged event, Emitter<TestState> emit) {
     emit(state.copyWith(
      email: event.email,
    ));
  }

}


// class TestBlock extends Bloc<TestEvent, TestState> {
//   TestBlock() : super(const TestState()) {
//     on<TestEmailChanged>(_onEmailChanged);
//
//   }
//
//   @override
//   void onTransition(Transition<TestEvent, TestState> transition) {
//     print(transition);
//     super.onTransition(transition);
//   }
//
//   void _onEmailChanged(TestEmailChanged event, Emitter<TestState> emit) {
//      emit(state.copyWith(
//       email: event.email,
//     ));
//   }
//
//
// }
