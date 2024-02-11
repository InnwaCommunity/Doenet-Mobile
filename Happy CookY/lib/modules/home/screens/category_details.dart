import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/themes/app_theme.dart';
import 'package:register_customer/model/category_model.dart';
import 'package:register_customer/model/use_report_model.dart';
import 'package:register_customer/modules/home/bloc/collect_report_state_management_bloc.dart';
import 'package:register_customer/modules/home/bloc/use_report_state_management_bloc.dart';
import 'package:register_customer/modules/home/repository/home_screen_repository.dart';
import 'package:register_customer/modules/home/screens/collect_details.dart';
import 'package:register_customer/modules/home/screens/use_report_detail.dart';


class CategoryDetails extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryDetails({super.key, required this.categoryModel});
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: DefaultTabController(
          length: 2,
          child: Column(children: [
            tabs(context),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BlocProvider(
                    create: (context) => UseReportStateManagementBloc(
                        HomeScreenRepositoryImpl()),
                    child: UseReportDetail(
                      categoryModel: categoryModel,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CollectReportStateManagementBloc(
                        HomeScreenRepositoryImpl()),
                    child: CollectDetails(
                      categoryIdval: categoryModel.categoryIdval!,
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }
  
  Widget _categoryListDetail(CategoryModel newCat) {
    double avausage = newCat.total! / newCat.usereportList!.length;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 0,
                top: 10,
                bottom: 10,
              ),
              child: LineChart(
                  mainData(newCat.usereportList!, avausage)),
            ),
          ),
        ],
      ),
    );
  }
  
  LineChartData mainData(List<UseReport> useRepList, double avaUsage) {
    List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
    List<FlSpot> spots=[];
    for (var i = 0; i < useRepList.length; i++) {
      FlSpot newspot=FlSpot(i.toDouble(), useRepList[i].useAmount!.toDouble());
      spots.add(newspot);
    }
    return LineChartData(
      backgroundColor: Colors.blue,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          // axisNameWidget: Text('Daily Usages'),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 5,
            getTitlesWidget: (value, meta) {
              int index = 0;
              if (value.toInt() > 0) {
                index = value.toInt();
              }
              if (index >= 0 && index < useRepList.length) {
                String text = useRepList[index].reportDate!;
                return Column(
                  children: [
                    Text(text.split('-').last,style: const TextStyle(fontSize: 10),),
                    Text(text.split('-')[1],style: const TextStyle(fontSize: 10),),
                    Text(text.split('-').first,style: const TextStyle(fontSize: 10),),
                  ],
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2000,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: useRepList.length.toDouble(),
      minY: 0,
      maxY: avaUsage,
    
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget tabs(BuildContext context) {
    return TabBar(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        Tab(
          child: FittedBox(
            key: const ValueKey('dutyReqrejected'),
            child: Text(
              tr('Report Details'),
            ),
          ),
        ),
        Tab(
          child: FittedBox(
            key: const ValueKey('dutyReqall'),
            child: Text(
              tr('Collect Details'),
            ),
          ),
        )
      ],
    );
  }
}

