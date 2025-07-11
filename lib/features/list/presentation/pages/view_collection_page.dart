import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/list/presentation/widgets/gridview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewCollectionPage extends StatefulWidget {
  const ViewCollectionPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => ViewCollectionPage());

  @override
  State<ViewCollectionPage> createState() => _ViewCollectionPageState();
}

class _ViewCollectionPageState extends State<ViewCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.turquoise500,
            size: 22.w,
          ),
        ),
        title: Text(
          "Tên bộ sưu tập",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: GridviewTab(
        isViewCollection: true,
      ),
    );
  }
}
