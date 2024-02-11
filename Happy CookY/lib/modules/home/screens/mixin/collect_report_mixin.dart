part of '../collect_details.dart';

mixin _CollectReportMixin on State<CollectDetails>{

  final TextEditingController colAmountController=TextEditingController();
  final TextEditingController descriptionController=TextEditingController();
  late FocusNode myFocusNode = FocusNode();
  var keyboardType=TextInputType.number;
  final loadingNotifier = ValueNotifier<bool>(false);
  final removeNotifier = ValueNotifier<bool>(false);
  GlobalKey stickyKey = GlobalKey();
  List<UserData> users=[];
  List<UserData> mentionUsers=[];
  List<CollectDatas> collectDatas=[];
  int totalValue=0;
  int possessValue=0;
  bool addAmount=true;
  bool mentionBox=true;


  @override
  void initState() {
    getDatas();
    super.initState();
  }

  void getDatas() async{
    BlocProvider.of<CollectReportStateManagementBloc>(context).add(GetPossessValue(categoryIdval: widget.categoryIdval));
    BlocProvider.of<CollectReportStateManagementBloc>(context).add(GetCollectReportList(categoryIdval: widget.categoryIdval));
  }
  
  void searchUsers(String data){
    BlocProvider.of<CollectReportStateManagementBloc>(context)
    .add(FrashUserList(
      userdata: data,categoryIdval: widget.categoryIdval));
  }

  void sendCollectReport(){
    BlocProvider.of<CollectReportStateManagementBloc>(context)
    .add(SaveCollectReport(
      collectval: int.parse(colAmountController.text),description: descriptionController.text));
  }
}