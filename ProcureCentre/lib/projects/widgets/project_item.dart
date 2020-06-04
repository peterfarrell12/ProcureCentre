import 'package:ProcureCentre/projects/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Project project;
  final GestureTapCallback deleteTapped;
  final PopupMenuButton popUp;

  ProjectItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.project,
    @required this.deleteTapped,
    @required this.popUp
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${project.id}'),
      onDismissed: onDismissed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color:    Colors.grey[200],)                           
              
              //  (project.status=='Initial')?Colors.redAccent:(project.status=='In Progress')? Colors.amber:(project.status=='Completed')? Colors.greenAccent: Colors.grey),
          ),
        ),
        child: ListTile(
          onTap: onTap,

          title:
              // Hero(
              // tag: '${project.name}__heroTag',
              // child:
              Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              project.name,
              //style: Theme.of(context).textTheme.title,
            ),
          ),
          // ),
          subtitle: project.user.isNotEmpty
              ? Text(
                  project.user,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  //style: Theme.of(context).textTheme.subhead,
                )
              : null,

          trailing: Wrap(
    spacing: 12,
            children: [
     popUp,
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 20,
                onPressed: deleteTapped,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

}