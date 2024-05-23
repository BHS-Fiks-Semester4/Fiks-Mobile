// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile/models/DataBarang.dart';

// class DataBarangWidget extends StatelessWidget {
//   final List<Barang> listBarang;

//   const DataBarangWidget({Key? key, required this.listBarang})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: listBarang.length,
//       itemBuilder: (context, index) {
//         final barang = listBarang[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           elevation: 2.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(bottom: 7.5),
//                         child: Text(
//                           barang.namaBarang,
//                           style: GoogleFonts.getFont(
//                             'Inria Sans',
//                             fontWeight: FontWeight.w700,
//                             fontSize: 12,
//                             height: 1.3,
//                             color: Color(0xFF8B8E99),
//                           ),
//                         ),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           text: 'Stok: ${barang.stokBarang}  ',
//                           style: GoogleFonts.getFont(
//                             'Inria Sans',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                             height: 1.3,
//                             color: Color(0xFF8B8E99),
//                           ),
//                         ),
//                       ),
                     
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 10), // Spacer
//                 SizedBox(
//                   width: 78.8,
//                   child: Text(
//                     'Rp. ${barang.hargaSetelahDiskonBarang.toStringAsFixed(2)}',
//                     style: GoogleFonts.getFont(
//                       'Inria Sans',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12,
//                       height: 1.3,
//                       color: Color(0xFF8B8E99),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
