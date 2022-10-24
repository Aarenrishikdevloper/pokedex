import 'dart:convert';
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:pokeapp/detail.dart';
import "data.dart";
import "package:http/http.dart" as http;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uri uri = Uri.parse("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  late pokedata Pokedata;
  bool loading = false;
  fetchdata() async{
    setState(() {
      loading = true;
    });
    var res = await http.get(uri);
    var decodejson =  jsonDecode(res.body);
    Pokedata = pokedata.fromJson(decodejson);
    print(Pokedata);
    setState(() {
      loading = false;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Poledex", style: GoogleFonts.fuzzyBubbles(color: Colors.white),),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loading?Container(
         child: Center(
            child: CircularProgressIndicator(color: Colors.cyan),

         ),
      ):GridView.count(
        padding: EdgeInsets.symmetric(horizontal:14),

         crossAxisCount: 2,
        children: Pokedata.pokemon!.map((poke) => Padding(
           padding: EdgeInsets.all(2.0) ,
          child: GestureDetector(
            onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Details(pokemon: poke,)));
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                    child:Hero(child: CachedNetworkImage(imageUrl: poke.img.toString(), fit: BoxFit.cover,), tag: poke.img.toString(),),
                  ),
                  Container(child: Text(poke.name.toString(), style: GoogleFonts.fuzzyBubbles(fontSize: 16, fontWeight: FontWeight.bold),)),
                 SizedBox(height: 5,)
                ],
              ),
            ),
          ),
        )).toList()
      )


    );
  }
}
