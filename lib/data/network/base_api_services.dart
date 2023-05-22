abstract class BaseApiServices{
  Future<dynamic> getApiResponse(String url);
  Future<dynamic> postAPiResponse(String url, dynamic data);
}