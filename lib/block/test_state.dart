import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class TestState extends Equatable {
   const  TestState({
     this.email = 'email===',
     this.phone = 'phone==',

   });

   final  String email;
   final String phone;

  TestState copyWith({
    String? email,
    String? phone,
  }) {
    return TestState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object> get props => [email,phone];

}