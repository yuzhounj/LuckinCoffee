import router from '@ohos.router'
import { CarPage } from './CarPage'
import { GoodPage } from './GoodPage'
import { homePage } from './HomePage'
import { Mine } from './Mine'
@Entry
@Component
struct Index {
  @State typeIndex: number = 0


  aboutToAppear(){
    const params = router.getParams()
    if(params !== undefined && params['typeIndex'] !== undefined) {
      this.typeIndex = parseInt(params['typeIndex'])
      console.log('testTab', `跳转到[${this.typeIndex}]`)
    }
  }
  build() {
    Column() {
      Tabs({ index: this.typeIndex, barPosition: BarPosition.End }) {
        TabContent() {
          homePage()
        }.tabBar(this.tabBuilder('首页', 0,$r('app.media.index1'),$r('app.media.index8')))
        TabContent() {
          if (this.typeIndex==1){
            GoodPage()
          }
        }.tabBar(this.tabBuilder('商品', 1,$r('app.media.index2'),$r('app.media.index7')))
        TabContent() {
          if (this.typeIndex==2){
            CarPage()
          }
        }.tabBar(this.tabBuilder('购物车', 2,$r('app.media.index3'),$r('app.media.index5')))
        TabContent() {
          if (this.typeIndex==3){
            Mine()
          }
        }.tabBar(this.tabBuilder('我的', 3,$r('app.media.index6'),$r('app.media.index4')))
      }
      .backgroundColor('#FFFFFF')
      .scrollable(true)
      .barHeight(70)
      .onChange(index => this.typeIndex = index)
    }
    .width('100%')
    .height('100%')
  }

  @Builder tabBuilder(text: string, index: number,img1:ResourceStr,img2:ResourceStr) {
    Column({ space: 5 }) {
      Image(this.typeIndex === index ? img2 : img1).width(30).height(30)
      Text(text)
        .fontSize(18)
        .fontColor(this.typeIndex === index ? '#0142D7' : '#686868')
        .fontWeight(500)
    }
    .width('100%')
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(15)
    .backgroundColor('#FFFFFF')
    .margin({top:-10})
    .onClick(() => this.typeIndex = index)
  }
}
