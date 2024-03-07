import 'package:github_search/core/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/usecases/get_main_info.dart';
part 'repo_event.dart';
part 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  GetMainInfo getMainInfo;

  RepoBloc(this.getMainInfo) : super(RepoInitialState()) {
    on<GetRepoEvent>(_getRepo);
  }



  var _mainEntity = const MainEntity(totalCount: 0, items: []);

  MainEntity get mainEntity => _mainEntity;


  ///Search Event
  void _getRepo(GetRepoEvent event, Emitter<RepoState> emit) async {

    emit(RepoLoadingState());
    if(event.query == null){
      _mainEntity = const MainEntity(totalCount: 0, items: []);
      emit(GotSuccessRepoState());
      return;
    }
    final gotRepo = await getMainInfo.call(GetMainParams(query: event.query!));
    RepoState state = gotRepo.fold(
      (error) => errorCheck(error),
      (data) {
        _mainEntity = data;
        return GotSuccessRepoState();
      },
    );
    emit(state);
  }




  RepoState errorCheck(Failure failure){
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return RepoInternetErrorState();
    }else if(failure is ServerFailure){
      return RepoErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return RepoErrorState(message: 'Повторите попытку');
    }
  }
} 
