import router from '@ohos.router'
import {
  AddLuckinShopcar,
  getLuckinGoodsList,
  getLuckinShopcar,
  removeLuckinShopcar,
  saveLuckinShopcar,
  SubLuckinShopcar
} from '../api/api'
import preferencesUtil from '../utils/PreferencesUtil'
import PreferencesUtil from '../utils/PreferencesUtil'
import { URL } from '../utils/request'
import { showToast } from '../utils/toast'
import { Address, addressList } from '../viewModel/Address'
import { coffee } from '../viewModel/Coffee'
import { ShopCar } from '../viewModel/ShopCar'
interface LuckinShopcarResponse {
  data: ShopCar[];
}
interface goodsResponse {
  data: coffee[];
}

@Entry
@Preview
@Component
export struct GoodPage {
  @State changeValue: string = ''
  @State submitValue: string = ''
  @State ShopCar: ShopCar = new ShopCar()
  controller: SearchController = new SearchController()

  @State fontColor: string = '#6A6A6A'
  @State selectedFontColor: string = '#353535'
  @State currentIndex: number = 0
  private controller1: TabsController = new TabsController()


  @State fontColor1: string = '#182431'
  @State selectedFontColor1: string = '#007DFF'
  @State currentIndex1: number = 0
  private controller2: TabsController = new TabsController()

  @State coffee:coffee[] = []
  @State phone:string = ''
  @State address1:Address[] = []
  @State isAddress:boolean = true;
  @State address:Address = new Address()

  @State car:ShopCar[] = []
  @State money:number = 0;
  @State money1:number = 0;
  @State isdialogController:boolean = true;

  scroller: Scroller = new Scroller()

  async aboutToAppear(): Promise<void> {
    try {
      // 获取购物车数据
      const response: LuckinShopcarResponse = await getLuckinShopcar();
      this.car = response.data;
      for (const item of this.car) {
        this.money += item.price || 0;
        this.money1 += item.price2 || 0;
      }

      // 获取登录状态
      let loginPreference: string | undefined;
      try {
        loginPreference = await PreferencesUtil.getPreferenceValue('app', 'Login') as string | undefined;
      } catch (error) {
        console.error('Failed to fetch login preference:', error);
        loginPreference = undefined;
      }
      this.phone = loginPreference ?? '';

      // 获取地址偏好
      let addressPreference: string | undefined;
      try {
        addressPreference = await PreferencesUtil.getPreferenceValue('app', 'address') as string | undefined;
      } catch (error) {
        console.error('Failed to fetch address preference:', error);
        addressPreference = undefined;
      }

      if (addressPreference) {
        this.isAddress = false;
        this.address = this.address1.find(item => item.address === addressPreference) || new Address();
      }

      // 获取商品列表
      const goodsListResponse:goodsResponse = await getLuckinGoodsList(1);
      this.coffee = goodsListResponse.data;

      console.log('i:' + this.phone);
      console.log('iiiii:' + addressPreference);
      console.log('address111:', this.address);

    } catch (error) {
      console.error('Error in aboutToAppear:', error);
    }
  }



  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .width('25')
        .color('#353995')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }

  @Builder TabBuilder1(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex1 === index ? this.selectedFontColor1 : this.fontColor1)
        .fontSize(16)
        .fontWeight(this.currentIndex1 === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })

    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
    .backgroundColor(this.currentIndex1 === index ? '#F2F2F2' : '#F6F6F6')
  }

  build(){
    Stack({ alignContent: Alignment.Bottom }){
      Column(){
        List(){
          ListItem(){
            Column(){
              Row(){
                Text('  拼单  ')
                  .lineHeight(25)
                  .borderWidth(1)
                  .borderRadius(15)
                Search({ value: this.changeValue, placeholder: 'Type to search...', controller: this.controller })
                  .height(35)
                  .width('85%')
                  .backgroundColor('#F5F5F5')
                  .placeholderColor(Color.Grey)
                  .placeholderFont({ size: 14, weight: 400 })
                  .textFont({ size: 14, weight: 400 })
                  .onSubmit((value: string) => {
                    this.submitValue = value
                  })
                  .onChange((value: string) => {
                    this.changeValue = value
                  }).margin({left:15})
              }.width('100%').padding(15)
              Row(){
                Column(){
                  Text(this.isAddress ? '北京店 >':`${this.address.address} >`).fontSize(15)
                  Text(this.isAddress ? '距离你337m >':`${this.address.distance} >`).margin({top:5}).fontSize(13).fontColor('#797979')
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
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              Row(){
                Text('葡萄柠檬茶上线，0脂·真果汁·超大杯').fontColor('#2E4BCA').fontSize(13).margin({left:15})
              }.width('95%').backgroundColor('#F4F7FE').height(30).borderRadius(30)
              Column(){
                Tabs({ barPosition: BarPosition.Start, controller: this.controller1 }) {
                  TabContent() {
                    Column(){
                      Row(){
                        Tabs({ barPosition: BarPosition.Start, controller: this.controller2 }) {
                          TabContent() {
                            List(){
                              ListItem(){
                                Column(){
                                  Row(){
                                    Column(){
                                      Text('人气Top').fontColor('#464646')
                                      Text('瑞幸必喝爆款，无限回购').fontSize(13)
                                        .fontColor('#989898')
                                        .margin({top:5})
                                    }.width('100%')
                                    .alignItems(HorizontalAlign.Start)
                                  }.width('100%').padding(15)
                                  ForEach(this.coffee,(item:coffee)=>{
                                    Row(){
                                      Row(){
                                        Image($r(item.resourcestr))
                                          .width(80)
                                          .height(100)
                                        Column(){
                                          Text(item.title).fontSize(15)
                                          Text(item.title2).fontSize(12).fontColor('#A7A7A7').margin({top:5})
                                          Row(){
                                            Text('￥'+item.price.toFixed(2)).fontWeight(700).fontColor('#EE5E41')
                                            Text('预估到手').fontSize(12).fontColor('#EE5E41').margin({left:5})
                                          }.width('100%').margin({top:15})
                                          Row(){
                                            Text('￥'+item.discountprice.toFixed(0)).fontWeight(700).fontColor('#979797')
                                            Text('面价').fontSize(13).margin({left:3}).fontColor('#BDBBBE')
                                            Text('￥'+item.price1.toFixed(0)).fontSize(13).margin({left:3}).fontColor('#BDBBBE')
                                              .decoration({
                                                type: TextDecorationType.LineThrough,
                                                color: '#BDBBBE'
                                              })
                                          }.width('100%').margin({top:5})
                                        }.width('60%').justifyContent(FlexAlign.Start)
                                        .alignItems(HorizontalAlign.Start)
                                        .margin({left:10})
                                      }.onClick(()=>{
                                        router.pushUrl({
                                          url:"pages/GoodDetails",
                                          params:{
                                            data:item
                                          }
                                        })
                                      })

                                      Text('+')
                                        .textAlign(TextAlign.Center)
                                        .width(20)
                                        .height(20)
                                        .fontColor(Color.White)
                                        .borderRadius(30)
                                        .backgroundColor('#0125B7')
                                        .onClick(async ()=>{
                                          // let i = 1
                                          // this.ShopCar.sum = i;
                                          // this.ShopCar.resourcestr = item.resourcestr
                                          // this.ShopCar.cupshaped = '大杯'
                                          // this.ShopCar.temperature = '冷'
                                          // this.ShopCar.brix = '不另外加糖'
                                          // this.ShopCar.title = item.title
                                          // this.ShopCar.price = item.price
                                          // this.ShopCar.price2 = item.price1
                                          // this.ShopCar.user = this.phone
                                          // this.money = this.money + this.ShopCar.price
                                          // this.money1 = this.money1 + this.ShopCar.price2
                                          // await saveLuckinShopcar(this.ShopCar)
                                          // showToast('添加成功！',2000)
                                          router.pushUrl({
                                            url:"pages/GoodDetails",
                                            params:{
                                              data:item
                                            }
                                          })
                                        })
                                    }.width('100%').justifyContent(FlexAlign.Start)
                                    .padding(15)
                                  })

                                }.width('100%')
                                .backgroundColor(Color.White)
                                .height(1000)
                              }.height(1000)
                            }
                          }.tabBar(this.TabBuilder1(0, '人气Top'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#007DFF')
                          }.tabBar(this.TabBuilder1(1, '今日特价'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#FFBF00')
                          }.tabBar(this.TabBuilder1(2, '爆款套餐'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(3, '下午茶推荐'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(4, '大闹天宫'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(5, '健康冰咖季'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(6, '生耶家族'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(7, '美式家族'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(8, '大师咖啡'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(8, '中国茶咖'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(8, '轻咖柠檬茶'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(9, '燕麦奶专区'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(10, '瑞纳冰'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(11, 'SOE小黑冰'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(12, '酱香拿铁'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(13, '生椰咖啡'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(14, '椰皇咖啡'))
                          TabContent() {
                            Column().width('100%').height('100%').backgroundColor('#E67C92')
                          }.tabBar(this.TabBuilder1(15, '牛逼咖啡'))
                        }
                        .vertical(true)
                        .barMode(BarMode.Fixed)
                        .barWidth(80)
                        .animationDuration(400)
                        .onChange((index: number) => {
                          this.currentIndex1 = index
                        })
                        .barPosition(BarPosition.Start)
                        .width('100%')
                        .height(1000)
                        .backgroundColor('#F1F3F5')
                      }.width('100%').height('100%').backgroundColor('#FFFFFF')
                      .margin({top:20})
                    }.width('100%').height('100%').backgroundColor('#00CB87')
                    .margin({top:20})
                    .justifyContent(FlexAlign.Start)
                    .alignItems(HorizontalAlign.Start)
                  }.tabBar(this.TabBuilder(0, '经典菜单'))
                  TabContent() {
                    Column().width('100%').height('100%').backgroundColor('#007DFF')
                  }.tabBar(this.TabBuilder(1, '每周9.9'))

                  TabContent() {
                    Column().width('100%').height('100%').backgroundColor('#FFBF00')
                  }.tabBar(this.TabBuilder(2, '轻咖下午茶'))

                  TabContent() {
                    Column().width('100%').height('100%').backgroundColor('#E67C92')
                  }.tabBar(this.TabBuilder(3, '我的常点'))
                }
                .vertical(false)
                .barMode(BarMode.Fixed)
                .barWidth(360)
                .barHeight(56)
                .backgroundColor(Color.White)
                .animationDuration(400)
                .onChange((index: number) => {
                  this.currentIndex = index
                })
                .width('100%')
              }.layoutWeight(1).width('100%')
            }

          }.height(1180)
        }
      }

      if (this.isdialogController){
        Row(){
          Row(){
            Image($r('app.media.app_icon'))
              .width(40).height(40)
            Column(){
              Row(){
                Text('预计到手').fontSize(16)
                Text('￥'+this.money.toFixed(2)).fontSize(16).fontColor('#E66241')
              }
              Text('已享受更低优惠，共减免'+(this.money1 - this.money).toFixed(2)).fontSize(12).fontColor('#ACACAC')
            }.width(180).justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .margin({left:15,top:-7})
          }
          .onClick(()=>{
            if (this.car.length>0) {
              this.isdialogController = !this.isdialogController
              this.money = 0
              this.money1 = 0
              this.aboutToAppear()
            }
          })

          if (this.car.length>0) {
            Button('去结算')
              .backgroundColor('#0024B6')
              .height('50')
              .width(100)
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/PayPage",
                  params:{
                    is:true
                  }
                })
              })
          }
          else {
            Button('不可结算')
              .backgroundColor('#B2BDEB')
              .height('50')
              .width(100)
              .fontColor('#FAFEFB')
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/PayPage",
                  params:{
                    is:true
                  }
                })
              })
          }
        }.width('95%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(15)
        .borderRadius(30)
        .height(50)
        .backgroundColor(Color.White)
        .margin({bottom:20})
      }else {
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            Row(){
              Text('已选购商品('+this.car.length+')件').fontSize(12).fontColor(Color.Black)
              Row(){
                Image($r('app.media.detele')).width(15).height(15)
                Text('清空购物车').fontSize(12).fontColor('#959595').margin({left:5})
              }
            }.width('100%').padding(15).justifyContent(FlexAlign.SpaceBetween)
            .onClick(async ()=>{
              this.isdialogController = !this.isdialogController
              await removeLuckinShopcar()
              this.money = 0
              this.money1 = 0
              this.aboutToAppear()
            })

              ForEach(this.car,(item:ShopCar)=>{
                Row(){
                  Image($r(item.resourcestr))
                    .width(70).height(70)
                  Column(){
                    Text(item.title).fontSize(14)
                    Row(){
                      Text(item.temperature+'/'+item.cupshaped+'/'+item.brix).fontSize(10)
                    }
                  }
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
                          this.money1 = 0
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
                }.width('100%')
                .height(80)
                .justifyContent(FlexAlign.SpaceBetween)
                .padding(15)
                .margin({bottom:10})
              })
          }
          .width('100%')
          .borderRadius({topRight:30,bottomRight:30 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
          .margin({bottom:60})

          Row() {
            Row() {
              Image($r('app.media.app_icon'))
                .width(40).height(40)
              Column() {
                Row() {
                  Text('预计到手').fontSize(16)
                  Text('￥' + this.money.toFixed(2)).fontSize(16).fontColor('#E66241')
                }

                Text('已享受更低优惠，共减免' + (this.money1 - this.money).toFixed(2))
                  .fontSize(12)
                  .fontColor('#ACACAC')
              }.width(180).justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 15, top: -7 })
            }
            .onClick(() => {
              this.isdialogController = !this.isdialogController
            })
            Button('去结算')
              .backgroundColor('#0024B6')
              .height('50')
              .width(100)
              .onClick(() => {
                router.pushUrl({
                  url: "pages/PayPage",
                  params: {
                    is: true
                  }
                })
              })
          }
          .shadow({ color: Color.Gray, radius: 10, offsetX: 15, offsetY: 15 })
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding(15)
          .borderRadius(30)
          .height(50)
          .backgroundColor(Color.White)
          .margin({ bottom: 20 })
        }.width('100%')
        .height('100%')


      }



    }.width('100%').height('100%')

  }

}

