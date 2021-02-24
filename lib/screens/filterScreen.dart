import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/FilterResponse.dart';
import 'package:nazarath_app/screens/filterprice.dart';
import '../main.dart';
import 'ProductList.dart';
import 'vertical_tabs.dart';
String f_filters="";
class FilterScreeen extends StatelessWidget {
  String by,sortBy, sortOrder,query, slug;
  FilterScreeen(String by, String sortBy, String sortOrder, String query, String slug)
  {
    this.by=by;
    this.sortBy=sortBy;
    this.sortOrder=sortOrder;
    this.query=query;
    this.slug=slug;
  }

  @override
  Widget build(BuildContext context) {
    f_filters="";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        automaticallyImplyLeading: true,
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios)),
        title: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
            child: ImageIcon(
              AssetImage("assets/icons/nazarath_logo.png"),
              size: appTabImageSize,
            ),
          ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      body:
      FutureBuilder<FilterResponse>(
        future: ApiCall()
            .execute<FilterResponse, Null>('filters/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return getFilterPage(context,snapshot.data,by,sortBy,sortOrder,query,slug);

          } else if (snapshot.hasError) {
            return errorScreen('Error: ${snapshot.error}');
             //return  getEmptyContainer(context, "No data", "empty_cart");

          } else {
            return progressBar;
          }
        },
      )
    );
  }
  
  Widget getFilterPage(BuildContext context, FilterResponse data,String by, String sortBy, String sortOrder, String query, String slug,)
  {
    Filters filter1=getFilterPrice(data.filters);
    Filters filter2=getFilter(1, data.filters);
    Filters filter3=getFilter(2, data.filters);
    Filters filter4=getFilter(3, data.filters);

   return SafeArea(
        child: Container(
          color: product_bg,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.refresh_rounded),
                          Text('Clear All'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                  child: VerticalTabs(
                    tabsWidth: 80,
                    direction: TextDirection.ltr,
                    contentScrollAxis: Axis.vertical,
                    changePageDuration: Duration(milliseconds: 020),
                    tabs: <Tab>[
                      Tab(child: Text(filter1.text)),
                      Tab(child: Text(filter2.text)),
                      Tab(child: Text(filter3.text)),
                      Tab(child: Text(filter4.text)),
                    ],
                    contents: <Widget>[
                      Container(child: FilterPrice(filters: filter1,)),
                      _listviewFilCat(filter2.values,context),
                      _listviewFilCat(filter3.values,context),
                      _listviewFilCat(filter4.values,context),

                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ProductScreen(slug,by,sortBy,sortOrder,f_filters,query)),
                  );
                },
                child: Container(
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(AssetImage('assets/icons/filtercontrol.png'),size: 30,color:colorPrimary),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Apply Filters',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:colorPrimary)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

//
//   Widget tabsContent(String caption, [String description = '']) {
//     return Container(
//       color: Colors.white,
//       margin: EdgeInsets.all(1),
//       padding: EdgeInsets.all(2),
//       child: Column(
//         children: <Widget>[
//           // Padding(
//           //   padding: const EdgeInsets.fromLTRB(15,20,15,15),
//           //   child: Container(
//           //     height: 30,
//           //     decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius:BorderRadius.all(Radius.circular(5),),
//           //         border: Border.all(color: product_bg)
//           //     ),),
//           // ),
//           Text(
//             caption,
//             style: TextStyle(fontSize: 25),
//           ),
//           Divider(
//             height: 20,
//             color: Colors.white,
//           ),
//           Text(
//             description,
//             style: TextStyle(fontSize: 15, color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }
// }

  Widget _listviewFilCat(List<Values> values,BuildContext context) =>
      ListView.builder(
          itemBuilder: (context, index) => _itemsBuilder(values[index],context),
          // separatorBuilder: (context, index) => Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          itemCount: values.length);

  Widget _itemsBuilder(Values value,BuildContext context) {
    bool status = false;
    return GestureDetector(onTap: () {}, child: _Cat(value,context));
  }
  Filters getFilter(int count,List<Filters>filters)
  {
    Filters filter=new Filters(type: "",text: "",values:new List<Values> () );
    if(filters.length>count)
      return filters[count];
    else
      return filter;
  }
  Filters getFilterPrice(List<Filters>filters)
  {
    Filters filter;
    for(int i=0;i<filters.length;i++)
      {
        if(filters[i].type=="price")
          return filters[i];
      }
    return filter;
  }
  Widget _Cat(Values value,BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Checkbox(
              value: true,
              activeColor: colorPrimary,
              focusColor: colorPrimary,
              onChanged: (value) {
                // setState(() {
                //   _value = value;
                // });
              },
            ),
            Container(
                width:MediaQuery.of(context).size.width*0.5,
                padding: EdgeInsets.only(right: 10),
                child: Text(value.name,maxLines: 10,overflow: TextOverflow.ellipsis,))
          ],
        ),
      ],
    );
  }

  Widget _listviewFilDelivery() =>
      ListView.builder(
          itemBuilder: (context, index) => _itemsBuilderDel(),
          // separatorBuilder: (context, index) => Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          itemCount: 6);

  Widget _itemsBuilderDel() {
    bool status = false;
    return GestureDetector(onTap: () {}, child: _listviewDel());
  }

  Widget _listviewDel() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Checkbox(
              value: true,
              activeColor: colorPrimary,
              focusColor: colorPrimary,
              onChanged: (value) {
                // setState(() {
                //   _value = value;
                // });
              },
            ),
            Text('Cash on Delivery')
          ],
        ),
      ],
    );
  }
}
