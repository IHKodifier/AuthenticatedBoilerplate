import 'package:AuthenticatedBoilerPlate/ui/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: ()=>HomeViewModel(),
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          actionsIconTheme: Theme.of(context).iconTheme.copyWith(color: Theme.of(context).primaryColor) ,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
        children: [
        Text('user Home',
        style:Theme.of(context).textTheme.button,
        ),
        RaisedButton(onPressed: model.signOut,
        color: Theme.of(context).primaryColor,
        child: Text('sign out',),)
        ],
          ),
        ),
      ),
    );
  }
}