part of '../home_screen.dart';
mixin _HomeScreenMixin on State<HomeScreen>{

  // ExpansionTileController expancontroller=ExpansionTileController();
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;
  ScrollController scrollController = ScrollController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String total = '';
  List<ClusterModel>? clusterList;
  List<CategoryModel> categoryList=[];

  @override
  void initState() {
    loadClusterList();
    super.initState();
  }

  void loadClusterList(){
    BlocProvider.of<HomeScreenStateManagementBloc>(context)
        .add(LoadClusterLists());
  }

}