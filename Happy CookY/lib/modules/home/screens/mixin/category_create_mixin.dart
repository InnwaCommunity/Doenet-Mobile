part of '../category_create_form.dart';

mixin _CategoryCreateMixin on State<CategoryCreateForm>{

  TextEditingController categoryName=TextEditingController();
  TextEditingController collectDescription=TextEditingController();
  TextEditingController collectValue = TextEditingController();
  final loadingNotifier = ValueNotifier<bool>(false);
  final removeNotifier = ValueNotifier<bool>(false);
  CategoryCreator? categoryCreator;
  DateTime? startDate;
  DateTime? endDate;

  
  void createCategory(){
    // BlocProvider.of<CategoryCreateFormStateManagementBloc>(context)
    // .add(const CreateCategory(
    //   categoryName: ,
    // ));
  }

  void searchMember(){
    BlocProvider.of<CategoryCreateFormStateManagementBloc>(context)
    .add(FrashMemberList(userdata: '', clusterIdval: widget.clusterIdval));
  }
}