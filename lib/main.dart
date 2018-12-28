import'dart:async';
import 'src/order.dart';
import 'src/cake.dart';

void main(List<String> args) {
  final controller = new StreamController();
  final order = new Order('banana');
  final baker = new StreamTransformer.fromHandlers(
    handleData: (cakeType , sink) {
      if(cakeType == 'chocolate'){
        sink.add(new Cake());
      }
      else {
        sink.addError('I cant bake that type!!!');
      }
    }
  );

  controller.sink.add(order);

  controller.stream
    .map((order) => order.type)
    .transform(baker)
    .listen(
      (cake) => print('Here your cake $cake') ,
      onError: (err) => print(err)
    );
}