import router from '@ohos.router'
import { getPhone } from '../api/api'
import { URL } from '../utils/request'
import { user } from '../viewModel/user'
@Entry
@Preview
@Component
export struct MindPage {
  @State user:user = new user()
  async aboutToAppear(){
    let p = router.getParams()['data']
    this.user = p
  }
  build() {
    Column(){
      Row(){
        Text('<').position({x:0,y:0}).width(30).height(30).fontSize(25)
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            router.back()
          })
        Text('个人资料').fontWeight(500).fontSize(23)
      }.width('100%').justifyContent(FlexAlign.Center)
      .padding(15)
      Column(){
        Row(){
          Text('头像').fontColor('#696969')
          Row(){
            Image(URL+this.user.photo)
              .width(45).height(45).borderRadius(30)
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(80)

        Row(){
          Text('用户名').fontColor('#696969')
          Row(){
            Text(this.user.username).fontSize(14).fontColor('#383838')
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

        Row(){
          Text('性别').fontColor('#696969')
          Row(){
            Text(this.user.gender).fontSize(14).fontColor('#383838')
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

        Row(){
          Text('关联手机号').fontColor('#696969')
          Row(){
            Text(this.user.phone).fontSize(14).fontColor('#383838')
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

      }.width('95%')
      .borderRadius(3)
      .padding(15)
      .backgroundColor(Color.White)

      Column(){
        Row(){
          Text('账号管理').fontColor('#696969')
          Row(){
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

        Row(){
          Text('免密支付').fontColor('#696969')
          Row(){
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

        Row(){
          Text('通用设置').fontColor('#696969')
          Row(){
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

        Row(){
          Text('协议与说明').fontColor('#696969')
          Row(){
            Text('>').margin({left:10}).fontSize(18).fontColor('#DDDDDD')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(50)

      }.width('95%')
      .borderRadius(3)
      .margin({top:10})
      .padding(15)
      .backgroundColor(Color.White)



    }.width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }
}