import router from '@ohos.router';
import { AddLuckinShopcar, deleteLuckinShopcar, getLuckinShopcar, saveLuckinOrde, saveLuckinShopcar, SubLuckinShopcar } from '../api/api'
import { URL } from '../utils/request';
import { showToast } from '../utils/toast';
import { ShopCar } from '../viewModel/ShopCar'
// 定义 API 响应接口，假设 getLuckinShopcar 返回一个包含 data 属性的对象
interface LuckinShopcarResponse {
  data: ShopCar[];
}
@Component
export struct CarPage {
  @State car:ShopCar[] = []
  @State money:number = 0;
  @State is:boolean = true
  @State goods:Array<number> = []
  aboutToAppear(): void {
    this.loadShopCarData();
  }

  private async loadShopCarData(): Promise<void> {
    try {
      const response:LuckinShopcarResponse= await getLuckinShopcar();
      this.car = response.data;

      // 确保 this.car 是一个数组，并且有 price 属性
      if (Array.isArray(this.car)) {
        this.money = this.car.reduce((sum, item) => sum + (item.price || 0), 0);
      }
    } catch (error) {
      console.error('Failed to fetch shop car data:', error);
      // 可以选择在此处显示用户友好的错误消息或采取其他措施
    }
  }
  build() {
    Column(){
        Row(){
          Text('咖啡订单').fontSize(22).fontWeight(700)
          Text('管理').fontSize(22).fontWeight(700).onClick(()=>{
            this.is = !this.is
          })
        }.width('100%')
        .padding(15)
        .justifyContent(FlexAlign.SpaceBetween)
        if (this.car.length>0){
          if (this.is) {
            List(){
              ListItem() {
                Column() {
                  ForEach(this.car, (item: ShopCar) => {
                    Row() {
                      Image($r(item.resourcestr)).width(75).height(75)
                      Row() {
                        Column() {
                          Text(item.title).fontSize(18)
                          Text('￥' + item.price.toFixed(2)).fontSize(20).fontColor(Color.Red)
                            .margin({ top: 15 })
                        }.width('40%').justifyContent(FlexAlign.Start)
                        .alignItems(HorizontalAlign.Start)
                        .margin({ left: 10 })

                        Row(){
                          Text('-').borderWidth(1)
                            .textAlign(TextAlign.Center)
                            .borderColor('#2945B8')
                            .fontColor('#2945B8')
                            .height(20).width(20).borderRadius(30)
                            .onClick(async ()=>{
                              if (item.sum>1) {
                                await SubLuckinShopcar(item.id,1)
                                this.money = 0
                                this.aboutToAppear()
                              }
                            })
                          Text(item.sum.toFixed(0)).margin({left:9})
                          Text('+')
                            .textAlign(TextAlign.Center)
                            .backgroundColor('#0022AB')
                            .fontColor(Color.White)
                            .height(20).width(20).borderRadius(30).margin({left:8})
                            .onClick(async ()=>{
                              if (item.sum<99) {
                                await AddLuckinShopcar(item.id,1)
                                this.aboutToAppear()
                              }
                            })
                        }.margin({left:20})
                      }.width('100%').justifyContent(FlexAlign.Start)
                    }
                    .width('93%')
                    .borderRadius(15)
                    .margin({ top: 10 })
                    .padding(15)
                    .backgroundColor('#FFFFFF')
                  })
                }.backgroundColor('#F6F6F6')
                .width('100%')
                .height('1000')
              }
            }
          }else {
            List(){
              ListItem() {
                Column() {
                  ForEach(this.car, (item: ShopCar) => {
                    Row() {
                      Checkbox({ name: item.id.toString(), group: 'checkboxGroup' })
                        .selectedColor('#007DFF')
                        .onChange((value: boolean) => {
                          console.info(item.id.toString() + value)
                          if (value) {
                            this.goods.push(item.id)
                          }else {
                            let good:number[] = []
                            for (let i = 0; i < this.goods.length ; i++) {
                              if (this.goods[i]!=item.id) {
                                good.push(this.goods[i])
                              }
                            }
                            this.goods = good
                          }
                        }).margin({left:-5})
                      Image($r(item.resourcestr)).width(75).height(75)
                      Row() {
                        Column() {
                          Text(item.title).fontSize(18)
                          Text('￥' + item.price.toFixed(2)).fontSize(20).fontColor(Color.Red)
                            .margin({ top: 15 })
                        }.width('40%').justifyContent(FlexAlign.Start)
                        .alignItems(HorizontalAlign.Start)
                        .margin({ left: 10 })
                      }.width('100%').justifyContent(FlexAlign.Start)
                    }
                    .width('93%')
                    .borderRadius(15)
                    .margin({ top: 10 })
                    .padding(15)
                    .backgroundColor('#FFFFFF')
                  })
                }.backgroundColor('#F6F6F6')
                .width('100%')
                .height('1000')
              }
            }
          }
        }else {
          Column(){
            Text('暂无订单').fontWeight(700).fontSize(30)
          }.width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      Row(){
        Text('共'+this.car.length+'杯').fontSize(20).fontWeight(700)
          .fontColor(Color.Black)
        Row(){
          if (this.car.length>0){
            Text('￥'+this.money.toFixed(2)).fontSize(20).fontColor(Color.Red)
          }else {
            Text('￥'+0).fontSize(20).fontColor(Color.Red)
          }
          if (this.is){
            Button('结算').margin({left:15})
              .onClick(async ()=>{
                router.pushUrl({
                  url:"pages/PayPage",
                  params:{
                    is:true
                  }
                })
              })
          }else {
            Button('删除').margin({left:15})
              .onClick(async ()=>{
                this.money = 0
                  console.log(this.goods.toString())
                for (let i = 0; i < this.goods.length; i++) {
                  await deleteLuckinShopcar(this.goods[i])
                }
                this.aboutToAppear()
              })
          }
        }
      }.position({x:0,y:'90%'})
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(15)
      .height(80)
      .backgroundColor('#FFFFFF')
    }.width('100%')
  }
}