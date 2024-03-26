

// import 'package:flutter/material.dart';

// class MyDropdown extends StatefulWidget {
//   final List<String> options;

//   MyDropdown({required this.options});

//   @override
//   _MyDropdownState createState() => _MyDropdownState();
// }

// class _MyDropdownState extends State<MyDropdown> {
//   TextEditingController _controller = TextEditingController();
//   List<String> _matchingOptions = [];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: _controller,
//             onChanged: (text) {
//               setState(() {
//                 _matchingOptions = widget.options
//                     .where((option) =>
//                         option.toLowerCase().contains(text.toLowerCase()))
//                     .toList();
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Type or Select an option',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           if (_matchingOptions.isNotEmpty)
//             Positioned(
//               width: MediaQuery.of(context).size.width,
//               child: Material(
//                 elevation: 4.0,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: _matchingOptions.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_matchingOptions[index]),
//                       onTap: () {
//                         _controller.text = _matchingOptions[index];
//                         setState(() {
//                           _matchingOptions.clear();
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';



class MyDropdown extends StatefulWidget {
  final List<String> options;

  MyDropdown({required this.options});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

// ... (previous code)

class _MyDropdownState extends State<MyDropdown> {
  TextEditingController _controller = TextEditingController();
  List<String> _matchingOptions = [];
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  _matchingOptions = widget.options
                      .where((option) =>
                          option.toLowerCase().contains(text.toLowerCase()))
                      .toList();
                  _showOverlay = _matchingOptions.isNotEmpty;
                });
              },
              onTap: () {
                setState(() {
                  _matchingOptions = widget.options;
                  _showOverlay = _matchingOptions.isNotEmpty;
                });
              },
              decoration: InputDecoration(
               hintText: 'Company',
                
              ),
            ),
            if (_showOverlay)
              Material(
                elevation: 4.0,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _matchingOptions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_matchingOptions[index]),
                      onTap: () {
                        _controller.text = _matchingOptions[index];
                        setState(() {
                          _showOverlay = false;
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}