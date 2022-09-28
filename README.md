# 📖 currency converter

## How to build the project
  git clone https://github.com/alhasan-s-aboobaid/currency_converter.git
  <br/> open **currency_converter** from Android studio
  <br/> Run **Flutter Run** in the terminal
 
## Used design pattern
  I used **TDD** design pattern in developing this app for those reasons:<br/>
  1- Faster Development<br/>
  2- Better Design : High cohesion , Low coupling<br/>
  3- A system developed with test driven development is going to have much less defects<br/>
  
## Used image loader library
  I used https://pub.dev/packages/flutter_svg due to use svg icons, SVGs are scalable and will render pixel-perfect at any resolution.
  
## Used database
  I have used NoSql technique with the help of this library https://pub.dev/packages/sembast , I used this type as the app is not too big and it is faster to prepear 

## Note
After I have implemented getting supported currencies requests using exchangerate-api.com , I was surprised that historical data needs to upgrade my plan.
but it provides /latest which returns last conversion rates for a specific currency. so I apply it instead :) 
