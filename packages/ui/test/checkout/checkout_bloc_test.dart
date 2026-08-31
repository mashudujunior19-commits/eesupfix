import 'package:bloc_test/bloc_test.dart';
import 'package:data/finance/models/payment_method.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/src/views/shop/checkout/bloc/checkout_bloc.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late MockOrderRepository orderRepository;

  final order = Order(
    customerId: 'customer-1',
    value: 250.0,
    paymentMethod: PaymentMethod.instapay,
    secretPin: 1234,
    status: OrderStatus.pending,
  );

  setUpAll(() {
    registerFallbackValue(order);
  });

  setUp(() {
    orderRepository = MockOrderRepository();
  });

  group('CheckoutBloc CheckoutStarted', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'emits CurrentCheckout seeded from the given products',
      build: () => CheckoutBloc(orderRepository),
      act: (bloc) => bloc.add(CheckoutStarted(const [])),
      expect: () => [
        isA<CurrentCheckout>()
            .having((s) => s.newOrder.value, 'value', 0.0)
            .having((s) => s.newOrder.status, 'status', OrderStatus.pending),
      ],
    );
  });

  group('CheckoutBloc OrderPlaced', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'emits [Loading, CheckoutCompleted] when outstandingAmount is 0',
      build: () => CheckoutBloc(orderRepository),
      seed: () => CurrentCheckout(order),
      setUp: () {
        when(() => orderRepository.createOrder(any())).thenAnswer(
          (_) async => const Right(
            (
              orderId: 123,
              outstandingAmount: 0.0,
              paymentId: null,
              secondaryId: null,
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(OrderPlaced()),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<CheckoutCompleted>()
            .having((s) => s.orderId, 'orderId', 123)
            .having((s) => s.isSuccess, 'isSuccess', true),
      ],
      verify: (_) {
        verify(() => orderRepository.createOrder(order)).called(1);
      },
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [Loading, OutstandingPayment] when outstandingAmount > 0',
      build: () => CheckoutBloc(orderRepository),
      seed: () => CurrentCheckout(order),
      setUp: () {
        when(() => orderRepository.createOrder(any())).thenAnswer(
          (_) async => const Right(
            (
              orderId: 123,
              outstandingAmount: 50.0,
              paymentId: 'pay_1',
              secondaryId: null,
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(OrderPlaced()),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<OutstandingPayment>()
            .having((s) => s.response.outstandingAmount, 'outstandingAmount', 50.0)
            .having((s) => s.paymentMethod, 'paymentMethod', PaymentMethod.instapay),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [Loading, CheckoutError] when the repository returns a Left',
      build: () => CheckoutBloc(orderRepository),
      seed: () => CurrentCheckout(order),
      setUp: () {
        when(() => orderRepository.createOrder(any())).thenAnswer(
          (_) async => Left(
            EESUpException(message: 'Please check your internet connection.'),
          ),
        );
      },
      act: (bloc) => bloc.add(OrderPlaced()),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<CheckoutError>()
            .having((s) => s.exception.message, 'message',
                'Please check your internet connection.'),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'does nothing when OrderPlaced is added outside of CurrentCheckout',
      build: () => CheckoutBloc(orderRepository),
      act: (bloc) => bloc.add(OrderPlaced()),
      expect: () => <CheckoutState>[],
      verify: (_) {
        verifyNever(() => orderRepository.createOrder(any()));
      },
    );
  });

  group('CheckoutBloc CheckoutFinished', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'emits CheckoutCompleted mirroring the event payload',
      build: () => CheckoutBloc(orderRepository),
      act: (bloc) => bloc.add(CheckoutFinished(456, false)),
      expect: () => [
        isA<CheckoutCompleted>()
            .having((s) => s.orderId, 'orderId', 456)
            .having((s) => s.isSuccess, 'isSuccess', false),
      ],
    );
  });
}
