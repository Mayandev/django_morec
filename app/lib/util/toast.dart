import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_recommend/public.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg, backgroundColor: AppColor.darkGrey, textColor: AppColor.white);
  }
}