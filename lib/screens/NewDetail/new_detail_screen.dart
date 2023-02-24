import 'package:flutter/material.dart';
import 'package:news_app_v1/theme/colors.dart';

class NewDetailScreen extends StatelessWidget {
  const NewDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColors.indigo)),
              SizedBox(height: 16),
              Text(
                "Lewandowski, Ballon d'Or için tüyo verdi, Messi yedincilik",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: MyColors.greyDark),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 14,
                  ),
                  SizedBox(width: 8),
                  Text('CNN Haber', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.grey1)),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 2, backgroundColor: MyColors.grey1),
                  SizedBox(width: 8),
                  Text('Kas 28, 2022', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.grey1)),
                ],
              ),
              SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    'https://picsum.photos/400/500',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Paris - Robert Lewandowski, prestijli ödül töreni geçen yıl pandemi nedeniyle iptal edildikten sonra Pazartesi günü geri döndüğünde, Lionel Messi'yi rekor kıran yedinci Ballon d'Or unvanını reddetmekle tehdit etti. \n\nBayern Münih ve Polonyalı forvet, geçen sezon sadece 29 maçta Bundesliga rekoru kırarak merhum Gerd Mueller tarafından belirlenen uzun süredir devam eden hedefi gölgede bıraktı.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: MyColors.greyDark),
              )
            ],
          ),
        ),
      ),
    );
  }
}
