import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import PreferencesUtil from '../utils/PreferencesUtil';
import { user } from '../viewModel/user';
import { getPhone } from '../api/api';
import { URL } from '../utils/request';


/**
 * 我的
 */
@Entry
@Component
export struct Mine {
  @State user:user = new user()
  async aboutToAppear(){
    let i = await PreferencesUtil.getPreferenceValue('app','Login') as string
    let rp2 = await getPhone(i)
    this.user = rp2.data
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        // 个人信息
        //todo 缺个背景图
        Row() {
          Image(URL+this.user.photo)
            .width(48)
            .height(48)
          Column() {
            Text(this.user.username+'>')
              .fontSize(20)
          }
          .margin({left:10})
          .alignItems(HorizontalAlign.Start)
        }.onClick(()=>{
          router.pushUrl({
            url:"pages/MindPage",
            params:{
              data:this.user
            }
          })
        })
        .margin({ top: 100 })
        // .alignItems(VerticalAlign.Center)
        .width('100%')
        // .height(200)
        .padding({ left: 20 ,bottom:10})
        .borderRadius(16)
        Row() {
          Column() {
            Text('LV.0小迷鹿')
              .fontSize(15)
            Row({space:150}){
              Text('0')
                .fontSize(25)
                .margin({top:15})
              Text("去喝一杯，加入瑞小幸！>")
                .fontSize(14)
                .fontColor(Color.Gray)
                .textAlign(TextAlign.End)
            }
            Line()
              .width(300)
              .height(5)
              .startPoint([0, 5])
              .endPoint([300, 5])
              .strokeWidth(5)
              .stroke(Color.Gray)
              .strokeOpacity(0.5)
              .backgroundColor(Color.White)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 5 })
        }
        .margin({ top: 20 })
        .alignItems(VerticalAlign.Center)
        .width('90%')
        .height(96)
        .backgroundColor(Color.White)
        .padding({ left: 20 })
        .margin({left:20,right:20})
        .borderRadius(16)

        // 功能列表
        Row({space:25}){
          Column(){
            Image($r('app.media.mine_1'))
              .width(42)
              .height(42)
            Text("我的订单")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({top:5})
          }.onClick(()=>{
            router.pushUrl({
              url:"pages/OrderPage"
            })
          })
          Column(){
            Image($r('app.media.mine_2'))
              .width(42)
              .height(42)
            Text("咖啡钱包")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({top:5})
          }
          Column(){
            Image($r('app.media.mine_3'))
              .width(42)
              .height(42)
            Text("优惠券")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({top:5})
          }
          Column(){
            Image($r('app.media.mine_4'))
              .width(42)
              .height(42)
            Text("招商加盟")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({top:5})
          }
          Column(){
            Image($r('app.media.mine_5'))
              .width(42)
              .height(42)
            Text("账户余额")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({top:5})
          }
        }.width("90%")
        .margin({top:10,bottom:10})
        .justifyContent(FlexAlign.Center)

        Row(){
          Image($r('app.media.pic_6'))
        }
          .alignItems(VerticalAlign.Center)
          .width('90%')
          .height(96)
          .backgroundColor(Color.White)
          // .padding({ left: 20 })
          .margin({top:20,left:20,right:20,bottom:20})
          .borderRadius(16)
        Row(){
          //todo 放在最左边
          Text("我的小幸运").fontSize(18).fontWeight(FontWeight.Bold).align(Alignment.Start)
          // Text("查看全部").fontSize(12).fontWeight(FontWeight.Bold).fontColor("#878987")
        }.margin({left:20,right:20,bottom:5})
        .justifyContent(FlexAlign.Start)
        Row(){
          Image($r('app.media.pic_12'))
        }
        .alignItems(VerticalAlign.Center)
        .width('90%')
        .height(96)
        .backgroundColor(Color.White)
        // .padding({ left: 20 })
        .margin({left:20,right:20})
        .borderRadius(16)
        Blank()

        Button('退出登录', { type: ButtonType.Capsule })
          .width('90%')
          .height(40)
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .backgroundColor("#212773")
          .margin({ bottom: 150 })
          .onClick(() => {
            promptAction.showToast({ message: '退出登录' })
            router.replaceUrl({ url: 'pages/Login' })
          })
      }
      .height('100%')
    }.backgroundColor('#EEEEEE')
  }
}function Spacer(arg0: { flex: number; }) {
throw new Error('Function not implemented.');
}
