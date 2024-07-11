import router from '@ohos.router'
import { getLuckinShopcar, removeLuckinShopcar, removeLuckinShopcarById, saveLuckinOrde } from '../api/api';
import DateUtil from '../utils/DateUtil';
import dateUtil from '../utils/DateUtil';
import PreferencesUtil from '../utils/PreferencesUtil';
import { URL } from '../utils/request';
import { showToast } from '../utils/toast';
import { Address, addressList } from '../viewModel/Address';
import { Order } from '../viewModel/Order';
import { ShopCar } from '../viewModel/ShopCar';
@Entry
@Preview
@Component
export struct payPage {

  @State car:ShopCar[] = []
  @State money:number = 0;
  @State money1:number = 0;
  @State isCar:boolean = true

  @State address:Address = new Address()
  @State address1:Address[] = []
  @State isAddress:boolean = true;
  @State userPhone:string = ''
  @State address2:string = ''

  async onPageShow(){
    let i = await PreferencesUtil.getPreferenceValue('app','address') as string
    let phone = await PreferencesUtil.getPreferenceValue('app','Login') as string
    this.userPhone = phone
    this.address1 = addressList
    if (i!==undefined&&i!==null){
      this.isAddress = false
      this.address = this.address1.filter(item=>item.address==i)[0]
    }
  }

  async aboutToAppear(){
    this.isCar = router.getParams()['is']
    if (this.isCar) {
      let response = await getLuckinShopcar()
      this.car =  response.data
      for (let i = 0; i <this.car.length; i++) {
        this.money = (this.money + this.car[i].price) * this.car[i].sum
        this.money1 = (this.money1 + this.car[i].price2) * this.car[i].sum
      }
    }else {
      let p = router.getParams()['data']
      this.car.push(p)
      this.money = (this.money + this.car[0].price) * this.car[0].sum
      this.money1 = (this.money1 + this.car[0].price2) * this.car[0].sum
    }
  }
  build(){
    Column(){
      List(){
        ListItem(){
          Column(){
            Row(){
              Text('<').position({x:0,y:0}).width(30).height(30).fontSize(25)
                .textAlign(TextAlign.Center)
                .onClick(()=>{
                  router.back()
                })
              Text('确认订单').fontWeight(500).fontSize(23)
            }.width('100%').justifyContent(FlexAlign.Center)
            .padding(15)
            Row(){
              Column(){
                Text(this.isAddress ? '北京中央广场店 >':`${this.address.address} >`).fontSize(15)
                Text(this.isAddress ? '红谷滩区红谷中大道998号绿地中央广场峰创国际一层大堂':`${this.address.location}`).margin({top:5}).fontSize(13).fontColor('#797979')
              }.width(200).justifyContent(FlexAlign.Start).height(70).alignItems(HorizontalAlign.Start)
              .padding(10)
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/AddressPage"
                })
              })
              Row(){
                Text(' 自提 ').backgroundColor('#343A9F').borderRadius(30).fontColor('#DFE1EC')
                Text(' 外卖 ').fontColor('#A1A1A1')
              }.backgroundColor('#F6F6F6').borderRadius(30)
              .height(25).margin({right:10})
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .height(100).backgroundColor(Color.White).borderRadius(15).margin({bottom:20})

            Row(){
              Column(){
                Text('立即自取，约09:40可取').fontSize(15)
                Text('金牌咖啡师正在等你下单').margin({top:5}).fontSize(13).fontColor('#797979')
              }.width(200).justifyContent(FlexAlign.Start).height(70).alignItems(HorizontalAlign.Start)
              .padding(10)
              Row(){
                Image($r('app.media.kfs'))
                  .width(50).height(50)
              }.backgroundColor('#F6F6F6').borderRadius(30)
              .height(25).margin({right:10})
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .height(100).backgroundColor(Color.White).borderRadius(15).margin({bottom:20})

            Column(){
              ForEach(this.car,(item:ShopCar)=>{
                Row(){
                  Row(){
                    Image(URL+item.resourcestr).width(80).height(80)
                    Column(){
                      Text(item.title)
                        .margin({bottom:10}).fontWeight(500).fontColor(Color.Black)
                      Text(item.temperature+'/'+item.brix)
                        .margin({bottom:10}).fontSize(14).fontColor('#A7A7A9')
                      Text('商品直减').borderWidth(1).borderColor('#EDC1BF')
                        .fontColor('#D7694F').padding(3)
                    }.margin({left:10}).width(100).justifyContent(FlexAlign.Start)
                    .alignItems(HorizontalAlign.Start)
                  }
                  Column(){
                    Row(){
                      Text('￥').fontSize(15).fontColor('#F05835')
                      Text(item.price.toFixed(1)).fontSize(22).fontWeight(600).fontColor('#F05835')
                        .margin({top:-5})
                    }
                    .margin({bottom:10})
                    Text('￥'+item.price2.toFixed(0)).fontColor('#A4A5A9')
                      .decoration({
                        type: TextDecorationType.LineThrough,
                        color: '#A4A5A9'
                      }).fontSize(15).margin({bottom:10})
                    Text('x'+item.sum)
                      .fontWeight(500)
                      .fontSize(12)
                      .fontColor('#888888')
                  }.width('150')
                  .margin({left:15})

                }.margin({top:5})
                .width('100%').padding(15)
              })
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({bottom:20})

            Row(){
              Text('支付方式')
              Text('微信支付 >')
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({bottom:20})
            .height(60).padding(15)

            Row(){
              Text('取餐方式')
              Row(){

                Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
                  .height(15)
                  .width(15)
                  .onChange((isChecked: boolean) => {
                    console.log('Radio1 status is ' + isChecked)
                  })
                  .borderColor('#E1D2BE')
                Text('店内用餐').fontSize(14)

                Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
                  .height(15)
                  .width(15)
                  .onChange((isChecked: boolean) => {
                    console.log('Radio1 status is ' + isChecked)
                  })
                  .borderColor('#E1D2BE')
                Text('自提带走').fontSize(14)

              }
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({bottom:20})
            .height(60).padding(15)


          }.height(1000)
        }
      }
      Row(){
        Column(){
          Row(){
            Text('应付 ')
            Text('￥'+this.money.toFixed(2)).fontSize(23).fontWeight(500)
          }.margin({top:5})
          Row(){
            Text('总计优惠￥'+(this.money1-this.money).toFixed(2)).fontColor('#F9613F')
          }.margin({top:5})
        }.width('50%').padding(15).justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
        Button('去支付')
          .width(120)
          .height(45)
          .margin({right:15})
          .backgroundColor('#F95731')
          .onClick(async ()=>{
            showToast(`支付成功！共支付${this.money}`,2000)
            for (let index = 0; index < this.car.length; index++) {
                  let order:Order = new Order()
                  order.sum = this.car[index].sum
                  order.resourcestr = this.car[index].resourcestr
                  order.title = this.car[index].title
                  order.price = this.car[index].price
                  order.money = this.car[index].price * this.car[index].sum
                  order.user = this.userPhone
                  order.brix = this.car[index].brix
                  order.temperature = this.car[index].temperature
                  order.cupshaped = this.car[index].cupshaped
                  order.address = this.isAddress ? '北京中央广场店':this.address.address
                  order.time = DateUtil.formatDateTime(DateUtil.beginTimeOfDay(new Date()))
                  await saveLuckinOrde(order)
                  await removeLuckinShopcarById(this.car[index].id).catch().finally()
            }
            router.replaceUrl({
              url:"pages/Index",
              params:{
                typeIndex:1
              }
            })

          })

      }.width('100%').backgroundColor(Color.White).height(90)
      .position({x:0,y:'89%'}).justifyContent(FlexAlign.SpaceBetween)

    }.backgroundColor('#F5F5F5')
  }
}