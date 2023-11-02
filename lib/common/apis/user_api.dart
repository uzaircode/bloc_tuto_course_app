import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/common/utils/http_util.dart';

class UserAPI {
  static login({LoginRequestEntity? params}) async {
    //response = response.data after the post method returns
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: params?.toJson(),
    );

    return UserLoginResponseEntity.fromJson(response);
  }
}
