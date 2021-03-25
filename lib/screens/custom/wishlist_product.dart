import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
// import 'package:nazarath_app/network/response/ProductListResponse.dart';
import 'package:nazarath_app/screens/ProductDetails.dart';

import '../ProductList.dart';
import '../home.dart';
class WishListProductList extends StatefulWidget {
  String slug, store;
  bool fav=false;
  double size;
  WishListProductList(int item,String slug,String store,double size)
  {
    if(item==1)
      fav = true;
    this.store=store;
    this.slug=slug;
    this.size=size;

  }
  @override
  _WishListProductListState createState() => _WishListProductListState(slug: this.slug,store:this.store,isFavorite: fav,size: this.size);
}
class _WishListProductListState extends State<WishListProductList>{
  int item;
  bool isFavorite = false;
  String slug, store;
  double size;
  _WishListProductListState({this.slug,this.store,this.isFavorite,this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(

          onTap: () {
            isFavorite = !isFavorite;
            if(!isFavorite) {
              removefromWishList(slug,store,context,widget);
            }
            else
            {
              addtoWishList(slug,store,context,widget);
            }
            setState(() {

            });
          },

          child: isFavorite?ImageIcon(
              AssetImage('assets/icons/fav_active.png'),
              size: size,
              color: colorPrimary,
            ) :ImageIcon(
            AssetImage('assets/icons/favourite.png'),
            size: size,
            color: colorPrimary,
          )
      )
    );

  }

}