import 'package:yt_ulearning/common/entities/entities.dart';
import 'package:yt_ulearning/common/utils/http_util.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('/api/courseList');

    print(response.toString());
    return CourseListResponseEntity.fromJson(response);
  }
}
