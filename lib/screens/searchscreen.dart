import 'package:flutter/material.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/SearchResponse.dart';
import 'package:nazarath_app/notifiers/searchnotifier.dart';
import 'package:nazarath_app/screens/ProductDetails.dart';

import 'package:provider/provider.dart';


class SearchScreen extends StatefulWidget {
  String from = 'Profile',hint;
  //var user;
  SearchScreen({this.from,this.hint});
  @override
  _SearchScreenState createState() => new _SearchScreenState(from: from,hint: hint);
}
class _SearchScreenState extends State<SearchScreen> {
  String from,hint;
  _SearchScreenState({this.from,this.hint
  });
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  SearchUpdateNotifier _updateNotifier;
  SearchResponse _searchResponse;
  @override
  void initState() {
    _updateNotifier =
        Provider.of<SearchUpdateNotifier>(context, listen: false);
    super.initState();
  }
  @override
  void dispose() {
    _updateNotifier.reset();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getViews(),
    );
  }
  Widget getViews()
  {
    return Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child:Container(
              margin: EdgeInsets.only(bottom: 40.7),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:60,right:10,left:10,bottom: 10),
                      height: 40,
                      padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 2),
                      child: TextField(
                        // decoration: new InputDecoration(
                        //     border: new OutlineInputBorder(
                        //         borderSide: new BorderSide(color: Colors.grey,)),
                        //     hintText: hint,
                        //     suffixIcon: const Icon(
                        //       Icons.search,
                        //     ),),
                          decoration: InputDecoration(
                            hintText: hint,
                            prefixIcon: const Icon(
                                    Icons.search,
                                  ),
                            hintStyle: TextStyle(fontSize: 12,),
                            fillColor: Color(0xFFEEEEF0),
                            contentPadding: EdgeInsets.only(top:5,bottom: 5,left:10,right: 10),
                            filled: true,
                              border:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              )
                          ),
                        onChanged: (text) {
                         SearchProduct(text);
                        },
                      ),
                    ),
                    Consumer<SearchUpdateNotifier>(
                      builder: (context, value, child) {
                        return value.searchResponse!=null ?  getSearchResult(value.searchResponse) : SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),

        ]
    );
  }
  Future<void> SearchProduct(String query)
  async {
    Map body={
      "query":query,

    };
    SearchResponse response = await ApiCall()
        .execute<SearchResponse, Null>("search-products/en", body);
    if(response!=null)
    {

      _updateNotifier.searchResponse=response;
    }
  }
  Widget getSearchResult(SearchResponse searchResponse)
  {
    _searchResponse=searchResponse;

    return Container(child:
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _searchResponse.products.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap:(){
              HandleOnClick(_searchResponse.products[index]);
            } ,
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width-20,

                  child:
                  Text(_searchResponse.products[index].name,
                    style: TextStyle(fontSize: 14,color: Colors.grey),),
                ),
                Divider()
              ],
            ),
          );

        }
    ),);
  }
  void HandleOnClick(Products searchItems)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
              searchItems.slug
          )),
    );
  }

  
}