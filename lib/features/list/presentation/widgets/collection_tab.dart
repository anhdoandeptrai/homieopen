import 'package:app_homieopen_3047/common/widgets/check_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'collection_item.dart';
import 'create_collection_button.dart';

class CollectionTab extends StatefulWidget {
  const CollectionTab({super.key});

  @override
  State<CollectionTab> createState() => _CollectionTabState();
}

class _CollectionTabState extends State<CollectionTab> {
  @override
  Widget build(BuildContext context) {
    return CheckLogin(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
        child: Column(
          spacing: 16.h,
          children: [
            // Nút tạo bộ sưu tập mới
            CreateCollectionButton(),
            // Danh sách bộ sưu tập
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.w,
                ),
                itemBuilder: (context, index) {
                  return CollectionItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
