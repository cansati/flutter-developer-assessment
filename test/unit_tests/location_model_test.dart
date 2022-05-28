import 'package:flutter_developer_assessment/model/location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart' as grpc;

import 'dart:async';
import 'dart:convert';
import 'dart:io' show File, HttpStatus;

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/generated/google/rpc/status.pb.dart';
import 'package:grpc/src/shared/status.dart';
import 'package:http2/transport.dart';
import 'package:protobuf/protobuf.dart';
import '../test_resources/client_utils.dart';
import '../test_resources/utils.dart';

void main() {
  test('simple-location-model', () {
    // The model should be able to receive the following data:
    final location = Location(
        id: 1, name: '', lat: 0.0, lon: 0.0, website: '', open_now: true);

    expect(location.id, 1);
    expect(location.name, '');
    expect(location.lat, 0.0);
    expect(location.lon, 0.0);
    expect(location.website, '');
    expect(location.open_now, true);
  });

  test('location-from-json', () {
    final file =
        File('test/test_resources/random_location.json').readAsStringSync();
    final location =
        Location.fromJson(jsonDecode(file) as Map<String, dynamic>);

    expect(location.id, 1);
    expect(location.name, "Place 1");
    expect(location.lat, 0.0);
    expect(location.lon, 0.0);
    expect(location.open_now, true);
    expect(location.website, "website");
  });

  test('location-to-json-string', () {
    final location = Location(
        id: 1, lat: 0.0, lon: 0.0, name: "", open_now: true, website: "");
    final String result = locationToJsonString([location]);

    expect(result,
        '[{"id":1,"lat":0.0,"lon":0.0,"name":"","open_now":true,"website":""}]');
  });

/*  test('grpc-maybe', () async {
    Future<grpc.ResponseStream> _mockRequest(grpc.RequestInfo request) async {
      return grpc.ResponseStream();
      grpc.
    }
  });*/
}

/*  const dummyValue = 0;
  late ClientHarness harness;

  setUp(() {
    harness = ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

test('Server-streaming calls work on the client', () async {
    const request = 4;
    const responses = [3, 17, 9];

    void handleRequest(StreamMessage message) {
      final data = validateDataMessage(message);
      expect(mockDecode(data.data), request);

      harness.sendResponseHeader();
      responses.forEach(harness.sendResponseValue);
      harness.sendResponseTrailer();
    }

    await harness.runTest(
      clientCall: harness.client.serverStreaming(request).toList(),
      expectedResult: responses,
      expectedPath: '/Test/ServerStreaming',
      serverHandlers: [handleRequest],
    );
  });*/
