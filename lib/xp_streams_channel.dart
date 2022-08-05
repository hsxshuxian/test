import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block/my_form_bloc.dart';
import 'block/test_block.dart';
import 'block/test_event.dart';
import 'block/test_state.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestBlock(),
      child: BlocBuilder<TestBlock, TestState>(
          bloc: TestBlock(), // provide the local bloc instance
          builder: (context, state) {
            // return widget here based on BlocA's state

            return Container(height: 100,color: Colors.blue,child: Text(state.email),);
          }
      )

    );



    // return BlocBuilder<TestBlock, TestState>(
    //   buildWhen: (previous, current) => previous.email != '',
    //   builder: (context, state) {
    //     // return Container(
    //     //   height: 20,
    //     //   width: 60,
    //     //   child: ElevatedButton(
    //     //     onPressed: (){},
    //     //     child: Text('ddd'),
    //     //     //child: Text(context.watch<TestBlock>().state.email),
    //     //   ),
    //     // );
    //   },
    // );
  }
}

class StreamChannelWidget extends StatefulWidget {
  const StreamChannelWidget({Key? key}) : super(key: key);

  @override
  StreamChannelWidgetState createState() => StreamChannelWidgetState();
}

class StreamChannelWidgetState extends State<StreamChannelWidget> {
  static final _channel = 'channelName';
  static final _platform = new MethodChannel(_channel);

  static final _channel2 = 'channelName2';
  static final _platform2 = new MethodChannel(_channel2);

 /// static final StreamsChannel _platformStream = new StreamsChannel(_streamChannel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 20,),

            CupertinoButton(
              color: Colors.green,
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('返回'),
            ),
            const SizedBox(height: 20,),
            CupertinoButton(
              color: Colors.green,
              onPressed: () async {

                var result;
                //异常捕获
                try {
                  //异步等待方法通道的调用结果
                  result = await _platform.invokeMethod('openAppMarket');
                }
                catch (e) {
                  result = -1;
                }
                print("Result：$result");



              },
              child: const Text('通信====iOS'),
            ),
            const SizedBox(height: 20,),
            CupertinoButton(
              color: Colors.green,
              onPressed: () async {

                var result;
                //异常捕获
                try {
                  //异步等待方法通道的调用结果
                  result = await _platform2.invokeMethod('_platform2');
                }
                catch (e) {
                  result = -1;
                }
                print("Result：$result");



              },
              child: const Text('通信====iOS'),
            ),
            const SizedBox(height: 20,),


            const SizedBox(height: 20,),

            CupertinoButton(
              color: Colors.green,
              onPressed: () async {

                context.read<TestBlock>().add(TestEmailChanged(email: '修改email=====1'));

              },
              child: const Text('block========'),
            ),



            // Text(state.email)

          ],
        ),
      ),
    );


  }
}

