
import 'package:equatable/equatable.dart';

abstract class TabState extends Equatable {
  const TabState();
}

class TabInitial extends TabState {
  @override
  List<Object> get props => [];
}
