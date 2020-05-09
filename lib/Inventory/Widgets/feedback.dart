import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/inventoryModels.dart';
import '../../Models/userModels.dart';
import '../../Providers&Services/inventory.dart';
import '../../SupplementaryWidgets/constants.dart';

class ItemUsageFeedback extends StatefulWidget {
  final InventoryItem inventoryItem;

  ItemUsageFeedback(this.inventoryItem);

  @override
  _ItemUsageFeedbackState createState() => _ItemUsageFeedbackState();
}

class _ItemUsageFeedbackState extends State<ItemUsageFeedback> {

  final _formKey = GlobalKey<FormState>();
  String _currentFeedback = 'Still Working';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Item Usage Feedback',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 40
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: _currentFeedback,
              decoration: textInputDecoration.copyWith(hintText: 'Enter Feedback',labelText: 'Feedback'),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              onChanged: (val) {
                setState(() {
                  _currentFeedback = val;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Return Item'),
              onPressed: () async {
                Inventory().returningingItem(widget.inventoryItem, _currentFeedback, Provider.of<User>(context,listen: false).uid);
                Navigator.of(context).pop();
                
              }
            )
            
          ],
        ),
      ),
    );
  }
}