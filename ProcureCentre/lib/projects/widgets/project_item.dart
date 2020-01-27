import 'package:ProcureCentre/projects/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Project project;

  ProjectItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${project.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: project.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${project.name}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              project.name,
              //style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: project.user.isNotEmpty
            ? Text(
                project.user,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                //style: Theme.of(context).textTheme.subhead,
              )
            : null,
      ),
    );
  }
}