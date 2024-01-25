import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Map<String, double> dataMap = {
    "Ticket en cours": 0,
    "Ticket cloturé": 0,
    "Ticket annulé": 0,
  };
    Map<int, double> monthlyTicketData = {};


  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase().then((_) {
      setState(() {});
    });
  }

  Future<void> fetchDataFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Tickets').get();

    // Resetting dataMap
    dataMap = {
      "Ticket en cours": 0,
      "Ticket cloturé": 0,
      "Ticket annulé": 0,
    };

    snapshot.docs.forEach((doc) {
      // Assuming you have a 'state' field in your documents
      String? Etat = doc['Etat'];

      // Incrementing the count based on the state (with null check)
      if (Etat != null) {
        if (Etat == "en cours") {
          dataMap["Ticket en cours"] = (dataMap["Ticket en cours"] ?? 0) + 1;
        } else if (Etat == "cloturé") {
          dataMap["Ticket cloturés"] = (dataMap["Ticket cloturé"] ?? 0) + 1;
        } else if (Etat == "annulé") {
          dataMap["Ticket annulé"] = (dataMap["Ticket annulé"] ?? 0) + 1;
        }
        
      }
    });
  }

 
  

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'statistique',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Tickets par état',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          PieChart(
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 1.4,
            legendOptions: LegendOptions(
              showLegends: false,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            colorList: [
              Color(0xFF411150),
              Color(0xFF6387B3),
              Color(0xFF1f3c90),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem("Ticket en cours", Color(0xFF411150)),
              _legendItem("Tickets cloturés", Color(0xFF6387B3)),
              _legendItem("Tickets annulés", Color(0xFF1f3c90)),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Répartition mensuelle des tickets',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _buildChart(),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 20,
            height: 20,
            color: color,
          ),
        ),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildChart() {
    final List<ChartData> chartData = [
      ChartData(12, 0),
      ChartData(2, 12),
      ChartData(3, 40),
      ChartData(4, 25),
      ChartData(5, 18),
      ChartData(6, 10),
      ChartData(7, 12),
      ChartData(8, 19),
      ChartData(9, 16),
      ChartData(10, 18),
      ChartData(11, 20),
      ChartData(12, 8),
    ];
    return Container(
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(),
        series: <CartesianSeries<ChartData, int>>[
          // Renders column chart
          ColumnSeries<ChartData, int>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
             color: const Color(0xFF411150),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
