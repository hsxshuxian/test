import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ios_channel/block/test_block.dart';
import 'package:flutter_ios_channel/block/test_event.dart';
import 'package:flutter_ios_channel/block/test_state.dart';
import 'package:flutter_ios_channel/route_util.dart';
import 'package:flutter_ios_channel/xp_streams_channel.dart';
import 'package:formz/formz.dart';

import 'block/my_form_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: [Locale('en', 'US'), Locale('en', 'US')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<MyFormBloc>(
            create: (BuildContext context) => MyFormBloc(),
          ),
          BlocProvider<TestBlock>(
            create: (BuildContext context) => TestBlock(),
          ),
        ],
        child: MyForm(),
      ),
      // body: BlocProvider(
      //   create: (_) => MyFormBloc(),
      //   child: MyForm(),
      // ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFormBloc, MyFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        }
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            EmailInput(focusNode: _emailFocusNode),
            PasswordInput(focusNode: _passwordFocusNode),
            SubmitButton(),
            //  SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: state.email.invalid ? 'Please ensure the email entered is valid' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<MyFormBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText: '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<MyFormBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBlock, TestState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(state.email),
            ElevatedButton(
              onPressed: () {
                ///获取修改的数据
                var testBlock = BlocProvider.of<TestBlock>(context);
                print('==testBlock====${testBlock.state.email}=');

                ///修改数据

              ////  fdfdfdffdfddfdfdf
                context.read<TestBlock>().add(TestEmailChanged(email: '==${testBlock.state.email}==1'));

                ///跳转
                // Navigator.push(context, RouteUtil.newCommonPageRoute(
                //     BlocProvider(
                //       create: (_) => TestBlock(),
                //       child: StreamChannelWidget(),
                //     ),
                //
                //    ));
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
