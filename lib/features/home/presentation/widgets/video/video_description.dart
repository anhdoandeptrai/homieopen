import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/home/data/models/video/video_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/read_more_cubit.dart';
import 'package:html/parser.dart' as html_parser;

class VideoDescription extends StatefulWidget {
  const VideoDescription({super.key, required this.video});
  final VideoEntity video;

  @override
  State<VideoDescription> createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoDescription> {
  String removeHtmlTags() {
    final document = html_parser.parse(widget.video.description);
    return document.body?.text ?? '';
  }

  @override
  void initState() {
    super.initState();
    context.read<ReadMoreCubit>().getFullText(removeHtmlTags());
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    if (!mounted) return;
    final cubit = context.read<ReadMoreCubit>();
    final fullText = cubit.state.fullText;

    // Define the text style and "Read More" suffix
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    const readMoreText = '... Xem thêm';

    // Create a TextSpan for the full text
    final span = TextSpan(
      text: fullText,
      style: textStyle,
    );

    // Create a TextPainter to measure the text
    final tp = TextPainter(
      text: span,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    // Use the actual width of the widget, accounting for padding/margins
    final availableWidth =
        context.size!.width - 16.0; // Adjust for padding if needed
    tp.layout(maxWidth: availableWidth);

    if (tp.didExceedMaxLines) {
      // Estimate the width of the "Read More" text
      final readMoreSpan = TextSpan(
        text: readMoreText,
        style: textStyle!.copyWith(color: AppColor.oslo600),
      );
      final readMorePainter = TextPainter(
        text: readMoreSpan,
        textDirection: TextDirection.ltr,
      );
      readMorePainter.layout();

      // Calculate the available width for the main text
      final textWidth = availableWidth - readMorePainter.width;

      // Create a TextPainter for the main text with the adjusted width
      final adjustedPainter = TextPainter(
        text: span,
        maxLines: 2,
        textDirection: TextDirection.ltr,
      );
      adjustedPainter.layout(maxWidth: textWidth);

      // Find the end index for the visible text
      final endIndex = adjustedPainter
          .getPositionForOffset(
            Offset(adjustedPainter.width, adjustedPainter.height),
          )
          .offset;

      // Ensure the text is truncated at a word boundary
      String visibleText = fullText.substring(0, endIndex).trim();
      if (endIndex < fullText.length) {
        final lastSpace = visibleText.lastIndexOf(' ');
        if (lastSpace > 0) {
          visibleText = visibleText.substring(0, lastSpace).trim();
        }
      }

      if (mounted) {
        cubit.prepareOverflow(
          visibleText: visibleText,
          isOverflowing: true,
        );
      }
    } else {
      if (mounted) {
        cubit.prepareOverflow(
          visibleText: fullText,
          isOverflowing: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadMoreCubit, ReadMoreState>(
      builder: (context, state) {
        return Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.video.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () => state.isOverflowing
                  ? context.read<ReadMoreCubit>().toggle()
                  : null,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: RichText(
                  key: ValueKey(state.isExpanded),
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: state.isExpanded
                              ? state.fullText
                              : state.visibleText),
                      if (state.isOverflowing)
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => context.read<ReadMoreCubit>().toggle(),
                            child: Text(
                              state.isExpanded ? ' Thu gọn' : '... Xem thêm',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColor.oslo600),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
