import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:videoit/models/service_api_response_models.dart';

part "service_api_calls.g.dart";

@RestApi(baseUrl: "http://192.168.0.102:",)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @POST("8999/login/")
  @Headers(<String, dynamic>{
    "AUTH_PROVIDER" : "GOAuth",
  })
  Future<LoginResponse> login(@Header('Authorization') String authorizationValue);


  @POST("8999/signup")
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<void> signUp(@Body() Map<String,dynamic> body);


  @GET("8999/session/getUser/{userName}")
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<UserProfileDetails> getUser(@Header('VI_SESSION') String sessionValue,@Header('VI_UID') String uuid,@Path("userName") String userName);


  @PUT('9000/content/management/upload')
  Future<void> uploadVideo(@Body() Map<String,dynamic> body);


  @GET('9000/content/management/video/getMetadata/{videoId}')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<VideoDetails> getVideoDetails(@Header('VI_SESSION') String sessionValue,@Header('VI_UID') String uuid,@Path("videoId") String videoId);



  @GET('9000/content/management/user/videos/getMetadata/{uuid}/{batchNumber}')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<List<VideoDetails>> getUserVideos(@Header('VI_SESSION') String sessionValue,@Header('VI_UID') String uuid,
     @Path("uuid") String useruid,@Path("batchNumber") int batchNumber);



  @GET('9000/content/management/stream/video/{videoId}')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<VideoStreamUrl> getVideoStreamUrl(@Header('VI_SESSION') String sessionValue,@Header('VI_UID') String uuid,@Path("videoId") String videoId);

}

