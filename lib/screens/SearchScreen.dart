import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Enter a city',
                    hintText: 'Example: tokyo',
                  ),
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.pop(context, textEditingController.text);
            },),
          ],
        ),
      ),
    );
  }
}
