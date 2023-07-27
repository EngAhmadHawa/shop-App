import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope/layout/screens/search_screen/cubit/search_state.dart';

import '../../../../models/search_model/search_model.dart';
import '../../../../shared/dio_helper/dio_helper.dart';
import '../../../../shared/remot/end_points.dart';
import '../../../../utils/constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print('the error is: ${error.toString()}');
      emit(SearchErrorState());
    });
  }
}