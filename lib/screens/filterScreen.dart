import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/FilterResponse.dart';
import 'package:nazarath_app/notifiers/filternotifier.dart';
import 'package:nazarath_app/screens/filterprice.dart';
import 'package:provider/provider.dart';
import '../languages.dart';
import '../main.dart';
import 'ProductList.dart';
import 'vertical_tabs.dart';
String f_filters="";
class FilterScreeen extends StatefulWidget {
  String by,sortBy, sortOrder,query, slug;
  double _lowerValue=0, _upperValue = 0;
  Filters filters;

  String get lowerValue => _lowerValue.toString();
  String get upperValue => _upperValue.toString();
  double getLowerValue()
  {

  }
  Currency currency;

  FilterScreeen(String by, String sortBy, String sortOrder, String query, String slug,)
  {
    this.by=by;
    this.sortBy=sortBy;
    this.sortOrder=sortOrder;
    this.query=query;
    this.slug=slug;
  }
  // FilterScreeen({this.filters,this.currency});
  @override
  _FilterScreeenState createState() => _FilterScreeenState();
}
RangeValues values = RangeValues(0, 100);
RangeLabels labels =RangeLabels("0", "100");
class _FilterScreeenState extends State<FilterScreeen> {
   List<String> valueArray ;
    double upValue=0;
   double lowValue=0;
  Filters filterPrice;
   FilterUpdatedNotifier _updateNotifier;
   @override
   void initState() {
     _updateNotifier =
         Provider.of<FilterUpdatedNotifier>(context, listen: false);
     super.initState();
   }
   @override
   void dispose() {
     values = RangeValues(0, 100);
     labels =RangeLabels("0", "100");
     _updateNotifier.reset();
     super.dispose();
   }
   Widget _rangeSlider(){
     if(filterPrice!=null)
     {
       if(filterPrice.pricevalues.length>1)
       {
         widget._lowerValue= double.parse(filterPrice.pricevalues[0]);
         widget._upperValue= double.parse(filterPrice.pricevalues[1]);
       }

     }
     lowValue=widget._lowerValue;
     upValue=widget._upperValue;
     double min=lowValue;
     double ratio=(upValue-lowValue)/100;
    // values = RangeValues(widget._lowerValue, widget._upperValue);
    // labels =RangeLabels(widget._lowerValue.toString(), widget._upperValue.toString());
     return Container(
         height: 50,
         decoration: BoxDecoration(
           borderRadius:
           BorderRadius.all(
             Radius.circular(20),
           ),

         ),
         child:
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 20,top: 20),
               child: Container(
                 color: Colors.white,
                 child: Text(Languages.of(context).selectPriceRange,style: TextStyle(fontSize: 12,color: textColor,fontWeight: FontWeight.bold),),
               ),
             ),
             RangeSlider(
                 divisions: 100,
                 activeColor: colorPrimary,
                 inactiveColor: Colors.grey[300],
                 min: 0,
                 max: 100,
                 values: values,
                 labels: labels,
                 onChanged: (value){
                   print("START: ${value.start}, End: ${value.end}");

                   setState(() {
                     values =value;
                     lowValue=min+((value.start)*ratio);
                     upValue=min+(value.end*ratio);
                     labels =RangeLabels(lowValue.toString(),upValue.toString());
                   });
                 }
             ),
           ],
         )
     );
   }

  @override
  Widget build(BuildContext context) {
    widget._lowerValue=0; widget._upperValue = 0;

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
            .execute<FilterResponse, Null>('filters/'+selectLanguage, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getFilterContent(snapshot.data);
            //return getFilterPage(context,snapshot.data,widget.by,widget.sortBy,widget.sortOrder,widget.query,widget.slug);

          } else if (snapshot.hasError) {
            return errorScreen('Error: ${snapshot.error}');
             //return  getEmptyContainer(context, Languages.of(context).noData, "empty_cart");

          } else {
            return progressBar;
          }
        },
      )
    );

  }

   // Widget _rangeSlider(){
   //   return Container(
   //       height: 50,
   //       decoration: BoxDecoration(
   //         borderRadius:
   //         BorderRadius.all(
   //           Radius.circular(20),
   //         ),
   //
   //       ),
   //       child:
   //       RangeSlider(
   //           divisions: 100,
   //           activeColor: colorPrimary,
   //           inactiveColor: Colors.grey[300],
   //           min: 1,
   //           max: 100,
   //           values: values,
   //           labels: labels,
   //           onChanged: (value){
   //             print("START: ${value.start}, End: ${value.end}");
   //
   //             setState(() {
   //               values =value;
   //               labels =RangeLabels(value.start.toString(),value.end.toString());
   //             });
   //           }
   //       )
   //   );
   // }

   Widget getFilterPage(BuildContext context, FilterResponse data,String by, String sortBy, String sortOrder, String query, String slug,)
  {
    List<Filters> listFilters=data.filters;
    filterPrice=getFilterPrice(listFilters);
    Filters filter2=getFilter(1, listFilters);
    Filters filter3=getFilter(2, listFilters);
  //  Filters filter4=getFilter(3, listFilters);
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
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            FilterScreeen(by,sortBy,sortOrder,query,slug)),
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.refresh_rounded),
                          Text(Languages.of(context).clearAll),
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
                      Tab(child: Text(filterPrice.text)),
                      Tab(child: Text(filter2.text)),
                      Tab(child: Text(filter3.text)),
                      //Tab(child: Text(filter4.text)),
                    ],
                    contents: <Widget>[
                      Container(color:Colors.white,child: _rangeSlider()),
                      Container(color:Colors.white,child: _listviewFilCat(filter2.values,context)),
                      Container(color:Colors.white,child: _listviewFilCat(filter3.values,context)),
                      //Container(color:Colors.white,child: _listviewFilCat(filter4.values,context)),

                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Map<String, Object>  typeObject =  new Map<String, Object>();
                   valueArray = new List<String>();
                   valueArray.add('"'+lowValue.toString()+'"');
                   valueArray.add('"'+upValue.toString()+'"');
                   List< Map<String, Object>> jsonarray=new List< Map<String, Object>>();
                  typeObject['"values"']=valueArray;
                  typeObject['"type"']='"price"';
                  jsonarray.add(typeObject);
                  for(int i=0;i<listFilters.length;i++)
                    {
                      Filters filter=listFilters[i];
                      if(filter.type!="price")
                        {
                          Map<String, Object>  typeObject_1 =  new Map<String, Object>();

                          List<String> valueArray_1=new List<String>();
                          if(filter.type=="specification")
                            {


                              for(int j=0;j<filter.values.length;j++)
                              {
                                Map<String, Object>  valueArrayObject =  new Map<String, Object>();
                                int fc=0;
                                if(filter.values[j].isSelected) {
                                  valueArrayObject['"field"'] = '"' + filter
                                      .values[j].filtervalue_id.toString() +
                                      '"';
                                  List<String> valueArray_2=new List<String>();
                                  fc++;
                                  for(int k=0;k<filter
                                      .values[j].filterSpecificationValues.length;k++)
                                    {

                                      valueArray_2.add('"' + filter.values[j].filterSpecificationValues[k].filterValueId
                                          .toString() + '"');
                                    }
                                  valueArrayObject['"values"'] = valueArray_2;

                                }
                                if(fc!=0)
                                  {
                                    typeObject_1['"type"'] = '"' + filter.type + '"';
                                    typeObject_1['"values"'] = valueArrayObject;
                                    jsonarray.add(typeObject_1);
                                  }
                              }
                            }
                          else
                            {
                              for(int j=0;j<filter.values.length;j++)
                              {
                                if(filter.values[j].isSelected)
                                  valueArray_1.add('"'+filter.values[j].filtervalue_id.toString()+'"');
                              }

                              if(valueArray_1.length>0) {
                                typeObject_1['"type"'] = '"' + filter.type + '"';
                                typeObject_1['"values"'] = valueArray_1;
                                jsonarray.add(typeObject_1);
                              }
                            }


                        }
                      // if(filter.isSelected)
                      //   {
                      //
                      //   }
                    }

                  Map<String, Object>  jsonObjct =  new Map<String, Object>();
                  jsonObjct['"filters"']= jsonarray;
                  print(jsonObjct.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ProductScreen(slug,by,sortBy,sortOrder,jsonObjct.toString(),query)),
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
                        child: Text(Languages.of(context).applyFilters,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:colorPrimary)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

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
            CheckBoxItem(filterValue: value,),
            GestureDetector(
              child: Container(

                  width:MediaQuery.of(context).size.width*0.5,
                  padding: EdgeInsets.only(right: 10),
                  child: Text(value.name,maxLines: 10,overflow: TextOverflow.ellipsis,)),
            )
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

  Widget getFilterContent(FilterResponse data) {

    _updateNotifier.filterResponse=data;

    return Consumer<FilterUpdatedNotifier>(
      builder: (context, value, child) {
        return value.filterResponse!=null ? getFilterPage(context,value.filterResponse,widget.by,widget.sortBy,widget.sortOrder,widget.query,widget.slug) : SizedBox();
      },
    );
  }
}
class CheckBoxItem extends StatefulWidget {
  Values filterValue;
  CheckBoxItem({this.filterValue});
  @override
  _CheckBoxItemState createState() => _CheckBoxItemState(filterValue: this.filterValue);
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  bool value = false;
  Values filterValue;

  _CheckBoxItemState({this.filterValue});
  @override
  Widget build(BuildContext context) {
    value=filterValue.isSelected;
    return Checkbox(

      activeColor: colorPrimary,
      focusColor: colorPrimary,
      value: this.value,
      onChanged: (bool value) {
        setState(() {
          this.value = value;
          filterValue.isSelected=value;

        });
      },
    ); //Checkbox
  }
}
