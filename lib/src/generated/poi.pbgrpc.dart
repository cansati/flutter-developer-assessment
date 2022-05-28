///
//  Generated code. Do not modify.
//  source: poi.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'poi.pb.dart' as $0;
export 'poi.pb.dart';

class PoiLocatorClient extends $grpc.Client {
  static final _$getPois = $grpc.ClientMethod<$0.PoiRequest, $0.PoiReply>(
      '/poi.PoiLocator/GetPois',
      ($0.PoiRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PoiReply.fromBuffer(value));

  PoiLocatorClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.PoiReply> getPois($0.PoiRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getPois, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class PoiLocatorServiceBase extends $grpc.Service {
  $core.String get $name => 'poi.PoiLocator';

  PoiLocatorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PoiRequest, $0.PoiReply>(
        'GetPois',
        getPois_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.PoiRequest.fromBuffer(value),
        ($0.PoiReply value) => value.writeToBuffer()));
  }

  $async.Stream<$0.PoiReply> getPois_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PoiRequest> request) async* {
    yield* getPois(call, await request);
  }

  $async.Stream<$0.PoiReply> getPois(
      $grpc.ServiceCall call, $0.PoiRequest request);
}

class AuthenticationClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginReply>(
      '/poi.Authentication/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginReply.fromBuffer(value));

  AuthenticationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.LoginReply> login($0.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }
}

abstract class AuthenticationServiceBase extends $grpc.Service {
  $core.String get $name => 'poi.Authentication';

  AuthenticationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginReply>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoginReply> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$0.LoginReply> login(
      $grpc.ServiceCall call, $0.LoginRequest request);
}
