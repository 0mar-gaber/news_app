import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/sources_model.dart';

class SourcesViewModel extends Cubit<SourcesState> {
  SourcesViewModel() : super(SourcesLoading());

  getSources(String categoryID, String languageCode) async {
    try {
      var sourcesResponse =
          await ApiManger.getAllSources(categoryID, languageCode);
      if (sourcesResponse.status == "error") {
        emit(SourcesError(
            errorMessage: sourcesResponse.message ?? "",
            statues: sourcesResponse.status.toString()));
      } else {
        var sourcesList = sourcesResponse.sources ?? [];
        emit(SourcesSuccess(listOfSources: sourcesList));
      }
    } catch (e) {
      emit(SourcesError(errorMessage: e.toString()));
    }
  }
}

abstract class SourcesState {}

class SourcesLoading extends SourcesState {}

class SourcesError extends SourcesState {
  String errorMessage;

  String statues;

  SourcesError({required this.errorMessage, this.statues = ""});
}

class SourcesSuccess extends SourcesState {
  List<SourceModel> listOfSources;

  SourcesSuccess({required this.listOfSources});
}
