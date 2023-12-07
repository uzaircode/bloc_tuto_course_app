import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yt_ulearning/common/apis/course_api.dart';
import 'package:yt_ulearning/common/entities/entities.dart';
import 'package:yt_ulearning/common/routes/routes.dart';
import 'package:yt_ulearning/common/widgets/flutter_toast.dart';
import 'package:yt_ulearning/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:yt_ulearning/pages/course/course_detail/bloc/course_detail_events.dart';

class CourseDetailController {
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAllData(args['id']);
  }

  asyncLoadAllData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);

    if (result.code == 200) {
      if (context.mounted) {
        print('----------context is ready----------');
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
      }
    } else {
      toastInfo(msg: "Something went wrong");
      if (kDebugMode) {
        print('----------Error Code ${result.code}----------');
      }
    }
  }

  void goBuy(int? id) async {
    print('${id}');
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;

    var result = await CourseAPI.coursePay(params: courseRequestEntity);

    EasyLoading.dismiss();
    if (result.code == 200) {
      var url = Uri.decodeFull(result.data!);

      var res = await Navigator.of(context).pushNamed(AppRoutes.PAY_WEB_VIEW, arguments: {'url': url});

      if (res == "success") {
        toastInfo(msg: "You bought it successfully");
      }
    } else {
      toastInfo(msg: result.msg!);
    }
  }
}
