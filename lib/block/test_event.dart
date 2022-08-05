import 'package:equatable/equatable.dart';


abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}


class TestEmailChanged extends TestEvent {
  const TestEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class TestRead extends TestEvent {
  const TestRead({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}
