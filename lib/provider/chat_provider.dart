import 'package:fb_login_google/contains/base_url.dart';
import 'package:fb_login_google/model/response/chat_response.dart';

import 'base_provider.dart';

class ChatProvider extends BaseProvider {
  Future<ChatResponse> getListChat({String uri}) async {
    try {
      if (uri == null) {
        uri = BaseUrl.url;
      }
      var jsonData = await this.get(uri);
      if (jsonData == null || jsonData['data'] == null) {
        return null;
      }
      return ChatResponse.fromJson(jsonData);
    }
    catch (e) {

    }
  }
}
