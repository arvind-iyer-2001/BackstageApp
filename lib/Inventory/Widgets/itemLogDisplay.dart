import 'package:backstage/Models/inventoryModels.dart';
import 'package:backstage/Providers&Services/inventory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemLogDisplay extends StatelessWidget {
  final String itemId;
  ItemLogDisplay(this.itemId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ItemLog>>(
      stream: Inventory(itemId: itemId).itemLog,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final itemLogs = snapshot.data;
        if(itemLogs.length <= 0 || !snapshot.hasData){
          return Center(
            child: Text('Item has not been used since registration'),
          );
        }
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              maxWidth: MediaQuery.of(context).size.width
            ),
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: itemLogs.length,
              itemBuilder: (context, index) {
                return ItemLogTile(itemLog: itemLogs[index]);
              },
            )
          ),
        );
      }
    );
  }
}

class ItemLogTile extends StatefulWidget {
  const ItemLogTile({
    @required this.itemLog,
  });

  final ItemLog itemLog;

  @override
  _ItemLogTileState createState() => _ItemLogTileState();
}

class _ItemLogTileState extends State<ItemLogTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 35,
              child: ListTile(
                title: Text(widget.itemLog.usageID),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                  print(isExpanded);
                },
              ),
            ),
            Divider(),
            if(isExpanded)
            Container(
              padding: EdgeInsets.all(3),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(DateFormat.yMEd().add_jms().format(widget.itemLog.borrowTime)),
                      Text( widget.itemLog.borrowTime.isBefore(widget.itemLog.returnTime)
                        ? '${DateFormat.yMEd().add_jms().format(widget.itemLog.returnTime)}'
                        : 'This Item is still in use'
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget.itemLog.borrowUserUid),
                      if(widget.itemLog.returnUserUid.length > 5)
                      Text(widget.itemLog.returnUserUid),
                      if(widget.itemLog.returnUserUid.length < 5)
                      Text('            ')
                    ],
                  ),
                  Divider(),
                  Text(widget.itemLog.feedback)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}