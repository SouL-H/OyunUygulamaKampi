/*
Not: Bazen tabletlerin ya da ekran boyutuna göre bir widgeti gösterip gizlemeyle ilgili konroller için layout builder kullanılıyor.

LayoutBuilder(
  builder:(context,constraints){
    if(constraints.maxWidth>550){
      return .... dönecek widget.
    }else{
      return ....
    }
  }
)

Bu şekilde boyutlara göre yansıtılacak ekran ayarlanabilir. 9.5 Adaptive ekran 12:51
 */