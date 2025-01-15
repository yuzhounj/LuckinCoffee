import router from '@ohos.router';
import { saveLuckinShopcar } from '../api/api';
import PreferencesUtil from '../utils/PreferencesUtil';
import { URL } from '../utils/request';
import { coffee } from '../viewModel/Coffee'
import { ShopCar } from '../viewModel/ShopCar';
interface RouterParams {
  data: coffee;
}
@Entry
@Component
export struct GoodDetails {
  @State coffee:coffee = new coffee();
  @State cupShaped:string = '大杯'
  @State temperature:string = '冰'
  @State brix:string = '标准糖'
  @State temBottom1:boolean = true
  @State temBottom2:boolean = false
  @State brixBottom1:boolean = true
  @State brixBottom2:boolean = false
  @State brixBottom3:boolean = false
  @State brixBottom4:boolean = false
  @State brixBottom5:boolean = false
  @State num:number = 1
  @State userPhone:string = ''
  car:ShopCar = new ShopCar()
  async aboutToAppear(){
    let i:string|undefined = await PreferencesUtil.getPreferenceValue('app','Login') as string|undefined
    if(i===undefined){}
    else{this.userPhone = i}
    let t:RouterParams= router.getParams() as RouterParams
    this.coffee=t.data;
  }

  build() {
    Column(){
        Row(){
          Text('<').position({x:20,y:20}).width(30).height(30).borderRadius(30)
            .backgroundColor('rgba(225, 225, 225, 0.5)').textAlign(TextAlign.Center)
            .onClick(()=>{
              router.back()
            })
        }.backgroundImage(URL+this.coffee.resourcestr2).width('100%').height(280)

        Column(){
          Text(this.coffee.title).fontWeight(500).fontSize(22).fontColor('#000000').margin({top:10})
          Text(this.coffee.title3).fontSize(15).fontColor('#333333').margin({top:7})

          Row(){
            Text('杯型：')
            Button({ type: ButtonType.Normal, stateEffect: true }){
              Text('大杯').fontColor('#1332B1').fontWeight(500)
            }
              .backgroundColor('#EAEEFF')
              .onClick(()=>{
                this.cupShaped = '大杯'
              })
              .borderRadius(1)
              .width(90)
              .height(30)
              .borderRadius(5)
          }.margin({top:30})

          Row(){
            Text('温度：')
            Button({ type: ButtonType.Normal, stateEffect: true }){
              Text('冰').fontColor(this.temBottom1 ? '#1332B1' : '#000000').fontWeight(500)
            }
            .backgroundColor(this.temBottom1 ? '#EAEEFF' : '#F7F7F7')
            .onClick(()=>{
              this.temperature = '冰'
              this.temBottom1 = true
              this.temBottom2 = false
            })
            .borderRadius(1)
            .width(90)
            .height(30)
            .borderRadius(5)
            .margin({right:7})

            Button({ type: ButtonType.Normal, stateEffect: true }){
              Text('热').fontColor(this.temBottom2 ? '#1332B1' : '#000000').fontWeight(500)
            }
            .backgroundColor(this.temBottom2 ? '#EAEEFF' : '#F7F7F7')
            .onClick(()=>{
              this.temperature = '热'
              this.temBottom2 = true
              this.temBottom1 = false
            })
            .borderRadius(1)
            .width(90)
            .height(30)
            .borderRadius(5)

          }.margin({top:30})

          Row(){
            Text('糖度：')
            Row(){
              Flex({wrap:FlexWrap.Wrap}){
                Button({ type: ButtonType.Normal, stateEffect: true }){
                  Text('标准糖').fontColor(this.brixBottom1 ? '#1332B1' : '#000000').fontWeight(500)
                }
                .backgroundColor(this.brixBottom1 ? '#EAEEFF' : '#F7F7F7')
                .onClick(()=>{
                  this.brix = '标准糖'
                  this.brixBottom1 = true
                  this.brixBottom2 = false
                  this.brixBottom3 = false
                  this.brixBottom4 = false
                  this.brixBottom5 = false
                })
                .borderRadius(1)
                .width(90)
                .height(30)
                .borderRadius(5).margin({right:7,bottom:7})

                Button({ type: ButtonType.Normal, stateEffect: true }){
                  Text('少甜').fontColor(this.brixBottom2 ? '#1332B1' : '#000000').fontWeight(500)
                }
                .backgroundColor(this.brixBottom2 ? '#EAEEFF' : '#F7F7F7')
                .onClick(()=>{
                  this.brix = '少甜'
                  this.brixBottom1 = false
                  this.brixBottom2 = true
                  this.brixBottom3 = false
                  this.brixBottom4 = false
                  this.brixBottom5 = false
                })
                .borderRadius(1)
                .width(90)
                .height(30)
                .borderRadius(5).margin({right:7,bottom:7})

                Button({ type: ButtonType.Normal, stateEffect: true }){
                  Text('少少甜').fontColor(this.brixBottom3 ? '#1332B1' : '#000000').fontWeight(500)
                }
                .backgroundColor(this.brixBottom3 ? '#EAEEFF' : '#F7F7F7')
                .onClick(()=>{
                  this.brix = '少少甜'
                  this.brixBottom1 = false
                  this.brixBottom2 = false
                  this.brixBottom3 = true
                  this.brixBottom4 = false
                  this.brixBottom5 = false
                })
                .borderRadius(1)
                .width(90)
                .height(30)
                .borderRadius(5).margin({right:7,bottom:7})

                Button({ type: ButtonType.Normal, stateEffect: true }){
                  Text('微甜').fontColor(this.brixBottom4 ? '#1332B1' : '#000000').fontWeight(500)
                }
                .backgroundColor(this.brixBottom4 ? '#EAEEFF' : '#F7F7F7')
                .onClick(()=>{
                  this.brix = '微甜'
                  this.brixBottom1 = false
                  this.brixBottom2 = false
                  this.brixBottom3 = false
                  this.brixBottom4 = true
                  this.brixBottom5 = false
                })
                .borderRadius(1)
                .width(90)
                .height(30)
                .borderRadius(5).margin({right:7,bottom:7})

                Button({ type: ButtonType.Normal, stateEffect: true }){
                  Text('不另外加糖').fontColor(this.brixBottom5 ? '#1332B1' : '#000000').fontWeight(500)
                }
                .backgroundColor(this.brixBottom5 ? '#EAEEFF' : '#F7F7F7')
                .onClick(()=>{
                  this.brix = '不额外加糖'
                  this.brixBottom1 = false
                  this.brixBottom2 = false
                  this.brixBottom3 = false
                  this.brixBottom4 = false
                  this.brixBottom5 = true
                })
                .borderRadius(1)
                .width(90)
                .height(30)
                .borderRadius(5).margin({right:7,bottom:7})

              }.margin({top:34})
            }.width('100%')
            .height(30)

          }.margin({top:30})
        }.width('100%').layoutWeight(1).margin({top:-10}).backgroundColor('#FFFFFF').borderRadius(15)
      .justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start).padding(15)


        Column(){
          Row(){
            Row(){
              Text('￥'+this.coffee.price).fontColor('#F95732').fontSize(25)
              Text('面价').fontColor('#ADADAD').fontSize(15).margin({left:5})
              Text('￥'+this.coffee.price1).fontColor('#ADADAD').fontSize(15)
                .decoration({
                  type: TextDecorationType.LineThrough,
                  color: '#ADADAD'
                })
            }
            Row(){
              Text('-').borderWidth(1)
                .textAlign(TextAlign.Center)
                .borderColor('#2945B8')
                .fontColor('#2945B8')
                .height(20).width(20).borderRadius(30)
                .onClick(()=>{
                  if (this.num>1) {
                    this.num--
                  }
                })
              Text(this.num.toFixed(0)).margin({left:9})
              Text('+')
                .textAlign(TextAlign.Center)
                .backgroundColor('#0022AB')
                .fontColor(Color.White)
                .height(20).width(20).borderRadius(30).margin({left:8})
                .onClick(()=>{
                  if (this.num<99) {
                    this.num++
                  }
                })
            }
          }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding(15)

          Row(){
            Text(this.coffee.title+this.coffee.price+'+'+this.temperature+'￥0+'+this.brix+'￥0').fontColor('#ADADAD').fontSize(14)
          }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding(15).margin({top:-20})

          Row(){
            Button(){
              Text('立即购买').fontColor('#AF9055')
            }
            .borderWidth(1)
            .borderColor('#AF9055')
            .backgroundColor('#FFFFFF')
            .width('45%')
            .height(40)
            .borderRadius(10)
            .onClick(()=>{
              this.car.brix = this.brix
              this.car.resourcestr = this.coffee.resourcestr
              this.car.title = this.coffee.title
              this.car.price = this.coffee.price
              this.car.price2 = this.coffee.price1
              this.car.user = this.userPhone
              this.car.cupshaped = this.cupShaped
              this.car.sum = this.num
              this.car.temperature = this.temperature
              router.pushUrl({
                url:"pages/PayPage",
                params:{
                  data:this.car,
                  is:false
                }
              })
            })

            Button(){
              Text('加入购物车').fontColor('#FFFFFF')
            }
            .onClick(async ()=>{
              this.car.brix = this.brix
              this.car.resourcestr = this.coffee.resourcestr
              this.car.title = this.coffee.title
              this.car.price = this.coffee.price
              this.car.price2 = this.coffee.price1
              this.car.user = this.userPhone
              this.car.cupshaped = this.cupShaped
              this.car.sum = this.num
              this.car.temperature = this.temperature
              await saveLuckinShopcar(this.car)
              router.replaceUrl({
                url:"pages/Index",
                params:{
                  typeIndex:1
                }
              })
            })
            .borderWidth(1)
            .backgroundColor('#0022AB')
            .width('45%')
            .height(40)
            .borderRadius(10)
          }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        }.backgroundColor(Color.White).width('100%').height(150)


    }.backgroundColor('#F5F5F5').height('100%').width('100%')
  }
}