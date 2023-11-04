import 'package:yt_ulearning/common/utils/http_util.dart';

class CourseAPI {
  static courseList() async {
    var response = await HttpUtil().post('/api/courseList');

    print(response.toString());
  }
}
