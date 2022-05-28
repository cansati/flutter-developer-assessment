import 'dart:async' as _i3;

import 'package:http2/src/hpack/hpack.dart' as _i4;
import 'package:http2/transport.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeClientTransportStream extends _i1.Fake
    implements _i2.ClientTransportStream {}

class _FakeStreamSink<S> extends _i1.Fake implements _i3.StreamSink<S> {}

/// A class which mocks [ClientTransportConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockClientTransportConnection extends _i1.Mock
    implements _i2.ClientTransportConnection {
  MockClientTransportConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isOpen =>
      (super.noSuchMethod(Invocation.getter(#isOpen), returnValue: false)
          as bool);
  @override
  set onActiveStateChanged(_i2.ActiveStateHandler? callback) =>
      super.noSuchMethod(Invocation.setter(#onActiveStateChanged, callback),
          returnValueForMissingStub: null);
  @override
  _i3.Future<void> get onInitialPeerSettingsReceived =>
      (super.noSuchMethod(Invocation.getter(#onInitialPeerSettingsReceived),
          returnValue: Future.value(null)) as _i3.Future<void>);
  @override
  _i2.ClientTransportStream makeRequest(List<_i4.Header>? headers,
          {bool? endStream = false}) =>
      (super.noSuchMethod(
          Invocation.method(#makeRequest, [headers], {#endStream: endStream}),
          returnValue:
              _FakeClientTransportStream()) as _i2.ClientTransportStream);
  @override
  _i3.Future<dynamic> ping() =>
      (super.noSuchMethod(Invocation.method(#ping, []),
          returnValue: Future.value(null)) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> finish() =>
      (super.noSuchMethod(Invocation.method(#finish, []),
          returnValue: Future.value(null)) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> terminate() =>
      (super.noSuchMethod(Invocation.method(#terminate, []),
          returnValue: Future.value(null)) as _i3.Future<dynamic>);
}

/// A class which mocks [ClientTransportStream].
///
/// See the documentation for Mockito's code generation for more information.
class MockClientTransportStream extends _i1.Mock
    implements _i2.ClientTransportStream {
  MockClientTransportStream() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<_i2.TransportStreamPush> get peerPushes =>
      (super.noSuchMethod(Invocation.getter(#peerPushes),
              returnValue: Stream<_i2.TransportStreamPush>.empty())
          as _i3.Stream<_i2.TransportStreamPush>);
  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  _i3.Stream<_i2.StreamMessage> get incomingMessages =>
      (super.noSuchMethod(Invocation.getter(#incomingMessages),
              returnValue: Stream<_i2.StreamMessage>.empty())
          as _i3.Stream<_i2.StreamMessage>);
  @override
  _i3.StreamSink<_i2.StreamMessage> get outgoingMessages =>
      (super.noSuchMethod(Invocation.getter(#outgoingMessages),
              returnValue: _FakeStreamSink<_i2.StreamMessage>())
          as _i3.StreamSink<_i2.StreamMessage>);
  @override
  set onTerminated(void Function(int?)? value) =>
      super.noSuchMethod(Invocation.setter(#onTerminated, value),
          returnValueForMissingStub: null);
  @override
  void sendHeaders(List<_i4.Header>? headers, {bool? endStream = false}) =>
      super.noSuchMethod(
          Invocation.method(#sendHeaders, [headers], {#endStream: endStream}),
          returnValueForMissingStub: null);
  @override
  void sendData(List<int>? bytes, {bool? endStream = false}) =>
      super.noSuchMethod(
          Invocation.method(#sendData, [bytes], {#endStream: endStream}),
          returnValueForMissingStub: null);
}
