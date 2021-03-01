import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/model/dialysis_solution_enum.dart';

class DialysisSolutionAvatar extends StatelessWidget {
  final DialysisSolutionEnum dialysisSolution;
  final bool isCompleted;
  final bool isDialysateColorNonRegular;

  const DialysisSolutionAvatar({
    Key key,
    @required this.dialysisSolution,
    this.isCompleted = true,
    this.isDialysateColorNonRegular = false,
  })  : assert(dialysisSolution != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: dialysisSolution.localizedName(context.appLocalizations),
      child: CircleAvatar(
        backgroundColor: dialysisSolution.color,
        foregroundColor: dialysisSolution.textColor,
        child: _getIcon(),
      ),
    );
  }

  Widget _getIcon() {
    if (!isCompleted) {
      return const Icon(Icons.sync_outlined);
    } else if (isDialysateColorNonRegular) {
      return const Icon(Icons.error_outline);
    } else {
      return null;
    }
  }
}
