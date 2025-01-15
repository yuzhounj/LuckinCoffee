import router from '@ohos.router';
import { deleteOrder, getLuckinOrdeList } from '../api/api';
import PreferencesUtil from '../utils/PreferencesUtil';
import { URL } from '../utils/request';
import { Order } from '../viewModel/Order'
interface orderL{
  data:Order[]
}
@Entry
@Preview
@Component
struct OrderPage {
  @State order:Order[] = [];

  async aboutToAppear(){
    let i = await PreferencesUtil.getPreferenceValue('app','Login') as string|undefined
    if(i===undefined){}
    else{
      let rp:orderL = await getLuckinOrdeList(i)
      this.order = rp.data
    }

  }

  build() {
    Column(){
      Row(){
        Text('<').position({x:0,y:0}).width(30).height(30).fontSize(25)
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            router.back()
          })
        Text('我的订单').fontWeight(500).fontSize(23)
      }.width('100%').justifyContent(FlexAlign.Center)
      .padding(15)
      List(){
        ListItem(){
          Column(){
            ForEach(this.order,(item:Order)=>{
              Column(){
                Row(){
                  Row(){
                    Text('自提').fontSize(14).width(40).height(20).backgroundColor('#C3A077')
                      .textAlign(TextAlign.Center)
                      .borderRadius(5).fontColor(Color.White)
                    Text(item.address).margin({left:5})
                  }
                  Row(){
                    Text('已经完成 | ').fontColor('#9A9A9A').fontSize(14)
                    Image($r('app.media.detele')).width(15).height(15)
                      .onClick(async ()=>{
                        await deleteOrder(item.id)
                        this.aboutToAppear()
                      })
                  }
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                .padding(10)
                .margin({top:5})
                Row(){
                  Divider().width('95%').color('#F2F2F2')
                }.width('100%').justifyContent(FlexAlign.Center)
                .margin({top:10,bottom:20})
                Row(){
                  Row(){
                    Image(URL+item.resourcestr).width(90).height(90)
                    Column(){
                      Text(item.title).fontWeight(700).fontSize(18)
                      Text(item.temperature+'/'+item.cupshaped+'/'+item.brix).margin({top:10})
                        .fontColor('#7C7C7C').fontSize(14).fontWeight(500)
                    }.width(200).alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.Start)
                    .margin({left:10})
                  }
                  Text('x '+item.sum).fontSize(15).fontColor('#999999').margin({right:15})
                }.width('100%').padding({left:15,right:15})
                .justifyContent(FlexAlign.SpaceBetween)

                Row(){
                  Row(){
                    Text(item.time)
                      .fontSize(10)
                      .fontColor('#9E9E9E')
                    Text(' luckin coffee小程序 ')
                      .fontSize(10).backgroundColor('#F2F2F2')
                      .fontColor('#86A9C9')
                      .borderRadius(2)
                      .margin({left:8})
                  }
                  Row(){
                    Text('共'+item.sum+'件商品 合计:').fontSize(10)
                    Text('￥'+item.price*item.sum).fontSize(12).fontWeight(600)
                  }
                }.width('100%').margin({top:20}).padding({left:10,right:10})
                .justifyContent(FlexAlign.SpaceBetween)
                Row(){
                  Button('再来一单')
                    .backgroundColor('#FFFFFF')
                    .borderWidth(2)
                    .borderColor('#0A2598')
                    .fontColor('#173083')
                    .height(35)
                    .onClick(()=>{
                      router.replaceUrl({
                        url:"pages/Index",
                        params:{
                          typeIndex:1
                        }
                      })
                    })
                }.width('100%').justifyContent(FlexAlign.End)
                .padding({left:15})
                .margin({top:10})
              }
              .margin({top:10})
              .width('95%')
              .borderRadius(7)
              .height(260)
              .backgroundColor(Color.White)
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
            })
          }.width('100%').margin({bottom:10})
        }.backgroundColor('#F6F6F6')
      }.backgroundColor('#F6F6F6').layoutWeight(1)
    }.width('100%')
    .backgroundColor('#F6F6F6')
  }
}