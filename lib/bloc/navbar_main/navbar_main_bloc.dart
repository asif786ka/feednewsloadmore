import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feednewsloadmore/enums/nav_bar_item.dart';
import 'package:meta/meta.dart';


part 'navbar_main_event.dart';
part 'navbar_main_state.dart';

class NavbarMainBloc extends Bloc<NavbarMainEvent, NavbarMainState> {
  NavbarMainBloc() : super(const NavbarMainState(NavbarItem.home)) {
    on<NavbarItemPressed>((event, emit) {
      emit(NavbarMainState(event.tappedItem));
    });
  }
}
