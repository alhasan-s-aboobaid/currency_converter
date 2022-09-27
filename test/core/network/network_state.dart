import 'package:currency_converter/core/network/network_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';


class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  NetworkStateImpl? networkStateImpl;
  MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkStateImpl = NetworkStateImpl(mockDataConnectionChecker!);
  });

  group('isConnected', () {
    test(
      'test if calling DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        print("here1");

        when(mockDataConnectionChecker!.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        print("here2");
        final result = networkStateImpl!.isConnected;
        // assert
        print("here3");
        verify(mockDataConnectionChecker!.hasConnection);
        print("here4");
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
