import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import  "package:cached_network_image/cached_network_image.dart";
import "data.dart";

class Details extends StatelessWidget {
  const Details({Key? key, required this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        centerTitle: true,
        title: Text(pokemon.name.toString(), style: GoogleFonts.fuzzyBubbles(),),
        leading: IconButton(
           icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){
             Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
         children: [
           Positioned(
             height: MediaQuery.of(context).size.height/1.4,
             width: MediaQuery.of(context).size.width-18,
             left: 10.0,


             top: MediaQuery.of(context).size.height*0.1,
             child: Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   SizedBox(height: 70,),
                   Text(pokemon.name.toString(), style: GoogleFonts.fuzzyBubbles(fontSize: 25, fontWeight: FontWeight.bold),),
                   Text("Height: ${pokemon.height.toString()}",style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold),),
                   Text("Weight: ${pokemon.weight.toString()}",style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold),),
                   Text("Types", style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold)),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: pokemon.type!.map((t) =>
                         FilterChip(
                           backgroundColor: Colors.amber,
                           label: Text(t, style: GoogleFonts.fuzzyBubbles(color: Colors.white),),
                           onSelected: (b){},
                         )
                     ).toList()
                   ),
                   Text("Weakness", style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold),),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: pokemon.weaknesses!.map((e) =>
                          FilterChip(
                            backgroundColor: Colors.red,
                             label: Text(e, style: GoogleFonts.fuzzyBubbles(color: Colors.white),),
                            onSelected: (b){},
                          )
                     ).toList()
                   ),
                   Text("Next Evolution", style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold)),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children:pokemon.nextEvolution == null?[Text("This is the final From", style: GoogleFonts.fuzzyBubbles(fontWeight: FontWeight.bold),)]:pokemon.nextEvolution!.map((m) =>
                         FilterChip(
                           label: Text(m.name.toString(), style: GoogleFonts.fuzzyBubbles(color: Colors.white),),
                           onSelected: (b){},
                           backgroundColor: Colors.green,
                         )
                     ).toList(),
                   )


                 ],
               ),
             ),
           ),
           Container(
             alignment: Alignment.topCenter,
             child: Hero(
               tag: pokemon.img.toString(),
               child: CachedNetworkImage(imageUrl: pokemon.img.toString(),fit: BoxFit.cover, height: 200, width: 200,),
             )
           )
         ],
      ),
    );
  }
}
