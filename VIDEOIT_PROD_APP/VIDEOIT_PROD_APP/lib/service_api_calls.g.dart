// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_api_calls.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://192.168.0.102:';
  }

  final Dio _dio;

  String baseUrl;

  @override
  login(authorizationValue) async {
    ArgumentError.checkNotNull(authorizationValue, 'authorizationValue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '8999/login/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'AUTH_PROVIDER': 'GOAuth',
              r'Authorization': authorizationValue
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  signUp(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    await _dio.request<void>('8999/signup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Content-Type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  getUser(sessionValue, uuid, userName) async {
    ArgumentError.checkNotNull(sessionValue, 'sessionValue');
    ArgumentError.checkNotNull(uuid, 'uuid');
    ArgumentError.checkNotNull(userName, 'userName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result =
        await _dio.request('8999/session/getUser/$userName',
            queryParameters: queryParameters,
            options: RequestOptions(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'VI_SESSION': sessionValue,
                  r'VI_UID': uuid
                },
                extra: _extra,
                contentType: 'application/json',
                baseUrl: baseUrl),
            data: _data);
    final value = UserProfileDetails.fromJson(_result.data);
    return value;
  }

  @override
  uploadVideo(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    await _dio.request<void>('9000/content/management/upload',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  getVideoDetails(sessionValue, uuid, videoId) async {
    ArgumentError.checkNotNull(sessionValue, 'sessionValue');
    ArgumentError.checkNotNull(uuid, 'uuid');
    ArgumentError.checkNotNull(videoId, 'videoId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result =
        await _dio.request('9000/content/management/video/getMetadata/$videoId',
            queryParameters: queryParameters,
            options: RequestOptions(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'VI_SESSION': sessionValue,
                  r'VI_UID': uuid
                },
                extra: _extra,
                contentType: 'application/json',
                baseUrl: baseUrl),
            data: _data);
    final value = VideoDetails.fromJson(_result.data);
    return value;
  }

  @override
  getUserVideos(sessionValue, uuid, useruid, batchNumber) async {
    ArgumentError.checkNotNull(sessionValue, 'sessionValue');
    ArgumentError.checkNotNull(uuid, 'uuid');
    ArgumentError.checkNotNull(useruid, 'useruid');
    ArgumentError.checkNotNull(batchNumber, 'batchNumber');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '9000/content/management/user/videos/getMetadata/$useruid/$batchNumber',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'VI_SESSION': sessionValue,
              r'VI_UID': uuid
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => VideoDetails.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getVideoStreamUrl(sessionValue, uuid, videoId) async {
    ArgumentError.checkNotNull(sessionValue, 'sessionValue');
    ArgumentError.checkNotNull(uuid, 'uuid');
    ArgumentError.checkNotNull(videoId, 'videoId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result =
        await _dio.request('9000/content/management/stream/video/$videoId',
            queryParameters: queryParameters,
            options: RequestOptions(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'VI_SESSION': sessionValue,
                  r'VI_UID': uuid
                },
                extra: _extra,
                contentType: 'application/json',
                baseUrl: baseUrl),
            data: _data);
    final value = VideoStreamUrl.fromJson(_result.data);
    return value;
  }
}
