part of '../use_report_detail.dart';

mixin _UseReportMixin on State<UseReportDetail>{

  List<UseReportDetailModel> useReportDetailModel=[];

  final TextEditingController useAmountController=TextEditingController();
  final TextEditingController descriptionController=TextEditingController();
  late FocusNode myFocusNode = FocusNode();
  var keyboardType=TextInputType.number;
  final loadingNotifier = ValueNotifier<bool>(false);
  final removeNotifier = ValueNotifier<bool>(false);
  GlobalKey stickyKey = GlobalKey();
  List<UserData> users=[];
  List<UserData> mentionUsers=[];

  bool addAmount=true;
  bool mentionBox=true;
  
  @override
  void initState() {
    super.initState();
    getUseReportList();
  }
  void getUseReportList(){
    BlocProvider.of<UseReportStateManagementBloc>(context).add(LoadUseReportList(categoryIdval: widget.categoryModel.categoryIdval!));
  }

  @override
  void dispose() {
    removeNotifier.value = true;
    super.dispose();
  }

  
  void sendUseReport(){
    BlocProvider.of<UseReportStateManagementBloc>(context)
    .add(SaveUseReportEvent(
      useAmount: useAmountController.text,
      description: descriptionController.text,
      categoryid: widget.categoryModel.categoryIdval!
    ));
  }

  void searchUsers(String data){
    BlocProvider.of<UseReportStateManagementBloc>(context)
    .add(FrashUserList(
      userdata: data,
      categoryIdval: widget.categoryModel.categoryIdval!));
  }
}