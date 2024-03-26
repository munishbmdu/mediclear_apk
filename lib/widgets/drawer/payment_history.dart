import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment History'),
          centerTitle: true,
        ),
        body: LabReportsTable(),
    
    );
  }
}

class LabReport {
  final String date;
  final String batchNo;
  final String payment;
  final String report;

  LabReport({required this.date, required this.batchNo, required this.payment, required this.report});
}

class LabReportsTable extends StatefulWidget {
  @override
  _LabReportsTableState createState() => _LabReportsTableState();
}

class _LabReportsTableState extends State<LabReportsTable> {
  late List<LabReport> labReports;
  late List<LabReport> filteredReports;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    labReports = [
      LabReport(date: '2023-01-01', batchNo: 'B123', payment: 'Pending', report: 'Pending'),
      LabReport(date: '2023-02-15', batchNo: 'B124', payment: 'Done', report: 'View'),
      // Add more lab reports as needed
    ];

    filteredReports = List.from(labReports);
    searchController = TextEditingController();
  }

  void searchReports(String query) {
    setState(() {
      filteredReports = labReports
          .where((report) =>
              report.batchNo.toLowerCase().contains(query.toLowerCase()) ||
              report.date.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchReports,
            decoration: InputDecoration(
              labelText: 'Search (Batch No or Date)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0, color: Colors.black)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Batch No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Payment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: List.generate(
                  filteredReports.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].date),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].batchNo),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].payment),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].report),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
