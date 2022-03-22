import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fab_nhl/app/resources/dimen.dart' as dimen;
import 'package:fab_nhl/ui/screen/common_widget/progress_bar.dart';

typedef SuccessWidgetBuilder<T> = Widget Function(BuildContext context, T item);
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, String? error);
typedef RefreshHandler = Future<void> Function();

class ResultListView<T> extends StatelessWidget {
  final List<T> data;
  final String? error;
  final bool isLoading;
  final RefreshHandler? onRefresh;
  final SuccessWidgetBuilder<T> itemBuilder;
  final ErrorWidgetBuilder? errorBuilder;

  const ResultListView(
      {Key? key,
      required this.data,
      required this.isLoading,
      this.error,
      required this.itemBuilder,
      this.onRefresh,
      this.errorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh!, child: _buildListView(context))
        : _buildListView(context);
  }

  _buildListView(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => itemBuilder(context, data[index])),
        Visibility(
            visible: isLoading, child: const Center(child: ProgressBar())),
        Visibility(
            visible: data.isEmpty && error?.isNotEmpty == true,
            child: errorBuilder != null
                ? errorBuilder!(context, error)
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.all(dimen.margin16),
                    child: Text(error ??
                        AppLocalizations.of(context).genericNetworkError),
                  )))
      ],
    );
  }
}
