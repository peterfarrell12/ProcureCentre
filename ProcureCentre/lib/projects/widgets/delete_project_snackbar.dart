import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';


class DeleteProjectSnackBar extends SnackBar {
  DeleteProjectSnackBar({
    Key key,
    @required Project project,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${project.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}