import router from '@ohos.router'
import { getPhone, getTopGoodsList } from '../api/api'
import PreferencesUtil from '../utils/PreferencesUtil'
import { URL } from '../utils/request'
import { coffee } from '../viewModel/Coffee'
import { user } from '../viewModel/user'
interface userRes{
  data:user
}
class IDataSource {
  list: ResourceStr

  constructor(list: ResourceStr) {
    this.list = list
  }
}

@Component
export struct homePage {
  private swiperController: SwiperController = new SwiperController()
  data: IDataSource[] = [
    new IDataSource($r('app.media.top1')),
    new IDataSource($r('app.media.top2')),
    new IDataSource($r('app.media.top3')),
    new IDataSource($r('app.media.top4'))
  ]
  data1: IDataSource[] = [
    new IDataSource($r('app.media.top1')),
    new IDataSource($r('app.media.top2')),
    new IDataSource($r('app.media.top3')),
    new IDataSource($r('app.media.top4'))
  ]
  @State coffee: coffee[] = [
    new coffee(
      "/images/goods/coffee_1.png",
      "/images/details/coffee_detail_1.png",
      "生椰拿铁",
      "3年突破7亿杯，原创YYDS!",
      "3年突破7亿杯 | 清爽椰香 | 0乳糖",
      13.00,
      30,
      21
    ),
    new coffee(
      "/images/goods/coffee_2.png",
      "/images/details/coffee_detail_2.png",
      "葡萄柠檬茶(超大杯)",
      "3年突破7亿杯，原创YYDS!",
      "3年突破7亿杯 | 清爽椰香 | 0乳糖",
      13.00,
      30,
      21
    ),
    new coffee(
      "/images/goods/coffee_3.png",
      "/images/details/coffee_detail_3.png",
      "葡萄冰萃美式",
      "3年突破7亿杯，原创YYDS!",
      "3年突破7亿杯 | 清爽椰香 | 0乳糖",
      13.00,
      30,
      21
    )
  ];
  @State user: user = new user()

  async aboutToAppear() {
    let userPreference : string | undefined;
    userPreference= await PreferencesUtil.getPreferenceValue('app', 'Login') as string|undefined;

    let rp2:userRes= await getPhone(userPreference||'')
    this.user = rp2.data

  }

  build() {
    Column() {
      List() {
        ListItem() {
          Column() {
            Row() {
              Swiper(this.swiperController) {
                ForEach(this.data, (item: IDataSource) => {
                  Column()
                    .width('100%')
                    .height(250)
                    .backgroundImage(item.list)
                    .backgroundImageSize({ width: '100%', height: '100%' })
                    .onClick(() => {
                      router.pushUrl({
                        url: "pages/Index" ,
                        params:{
                          typeIndex:1
                        }
                      });
                    })
                })
              }
              .cachedCount(2)
              .index(1)
              .autoPlay(true)
              .interval(4000)
              .indicator(true)
              .loop(true)
              .duration(1000)
              .itemSpace(0)
              .indicatorStyle({
                bottom: 120,
                color: '#FFFFFF',
                selectedColor: '#FFFFFF'
              })
              .curve(Curve.Linear)
              .onChange((index: number) => {
                console.info(index.toString())
              })
            }

            Column() {
              Row() {
                Row() {
                  Image(URL + this.user.photo).width(25).height(25)
                  Text(`Hey,${this.user.username}来跟幸运打个招呼`)
                    .fontColor('#BA9E67')
                    .fontSize(14)
                    .margin({ left: 7 })
                }

                Text('Lv2 小银鹿').fontColor('#BA9E67').fontSize(14)
              }
              .width('93%')
              .backgroundColor('#22292F')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(43)
              .padding(15)
              .borderRadius({ topLeft: 10, topRight: 10 })

              Column() {
                Row() {
                  Column() {
                    Image($r('app.media.min1'))
                      .width(80)
                      .height(80)
                    Text('到店取')
                      .fontWeight(700)
                      .fontSize(20)
                      .margin({ top: 7 })
                    Text('提前点单免排队')
                      .fontSize(12)
                      .fontColor('#9C9C9C')
                      .margin({ top: 7 })
                  }

                  Column() {
                    Image($r('app.media.min2'))
                      .width(80)
                      .height(80)
                    Text('幸运送')
                      .fontWeight(700)
                      .fontSize(20)
                      .margin({ top: 7 })
                    Text('外卖及时送达')
                      .fontSize(12)
                      .fontColor('#9C9C9C')
                      .margin({ top: 7 })
                  }

                  Column() {
                    Image($r('app.media.min3'))
                      .width(80)
                      .height(80)
                    Text('电商购')
                      .fontWeight(700)
                      .fontSize(20)
                      .margin({ top: 7 })
                    Text('囤咖啡买周边')
                      .fontSize(12)
                      .fontColor('#9C9C9C')
                      .margin({ top: 7 })
                  }
                }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

                Row() {
                  Column() {
                    Image($r('app.media.min4'))
                      .width(50)
                      .height(50)
                    Text('充4赠3').fontColor('#383838').fontWeight(500).margin({ top: 7 }).fontSize(15)
                    Text('咖啡钱包').fontColor('#9F9F9F').fontSize(12).margin({ top: 7 })
                  }

                  Column() {
                    Image($r('app.media.min5'))
                      .width(50)
                      .height(50)
                    Text('礼品卡').fontColor('#383838').fontWeight(500).margin({ top: 7 }).fontSize(15)
                    Text('送TA咖啡').fontColor('#9F9F9F').fontSize(12).margin({ top: 7 })
                  }

                  Column() {
                    Image($r('app.media.min6'))
                      .width(50)
                      .height(50)
                    Text('多人团餐').fontColor('#383838').fontWeight(500).margin({ top: 7 }).fontSize(15)
                    Text('一键开票').fontColor('#9F9F9F').fontSize(12).margin({ top: 7 })
                  }

                  Column() {
                    Image($r('app.media.min7'))
                      .width(50)
                      .height(50)
                    Text('优惠联盟').fontColor('#383838').fontWeight(500).margin({ top: 7 }).fontSize(15)
                    Text('超级权益').fontColor('#9F9F9F').fontSize(12).margin({ top: 7 })
                  }
                }.width('100%').justifyContent(FlexAlign.SpaceEvenly)
              }
              .width('93%')
              .backgroundColor('#FFFFFF')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(280)
              .padding(15)
              .borderRadius(15)

              Row() {
                Swiper(this.swiperController) {
                  ForEach(this.data, (item: IDataSource) => {
                    Column()
                      .width('93%')
                      .height(80)
                      .backgroundImage(item.list)
                      .backgroundImageSize({ width: '100%', height: '100%'})
                      .onClick(() => {
                        router.pushUrl({
                          url: "pages/Index" ,
                          params:{
                            typeIndex:1
                          }
                        });
                      })
                  })
                }
                .borderRadius(15)
                .cachedCount(2)
                .index(1)
                .autoPlay(true)
                .interval(4000)
                .indicator(true)
                .loop(true)
                .duration(1000)
                .itemSpace(0)
                .indicatorStyle({
                  bottom: 0,
                  color: '#C1C1C0',
                  selectedColor: '#C1C1C0'
                })
                .curve(Curve.Linear)
                .onChange((index: number) => {
                  console.info(index.toString())
                })
              }.margin({ top: 10 })

              Column() {
                Row() {
                  Text('我的优惠专区')
                }.padding(15)
                .width('100%')

                Row() {
                  Image($r('app.media.bottom1'))
                    .width(150).height(180)
                    .onClick(() => {
                      router.pushUrl({
                        url: "pages/GoodDetails",
                        params: {
                          data: this.coffee[0]
                        }
                      })
                    })
                  Column() {
                    Image($r('app.media.bottom2'))
                      .width(150).height(85)
                      .onClick(() => {
                        router.pushUrl({
                          url: "pages/GoodDetails",
                          params: {
                            data: this.coffee[1]
                          }
                        })
                      })
                    Image($r('app.media.bottom3'))
                      .width(150).height(85)
                      .margin({ top: 10 })
                      .onClick(() => {
                        router.pushUrl({
                          url: "pages/GoodDetails",
                          params: {
                            data: this.coffee[2]
                          }
                        })
                      })
                  }.height(180)
                }.width('100%').padding({ left: 15, right: 15 })
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .width('93%')
              .height(250)
              .margin({ top: 10 })
              .borderRadius(15)
              .backgroundColor('#FFFFFF')
            }.margin({ top: -44 })
          }
          .width('100%')
        }
      }
    }.width('100%').backgroundColor('#F6F6F6')
  }
}