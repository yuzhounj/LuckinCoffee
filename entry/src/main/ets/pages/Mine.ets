import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import PreferencesUtil from '../utils/PreferencesUtil';
import { user } from '../viewModel/user';
import { getPhone } from '../api/api';
import { URL } from '../utils/request';

interface userRes{
  data:user
}
/**
 * 我的页面组件
 */
@Entry
@Component
export struct Mine {
  @State user:user = new user()  // 用户信息状态

  // 页面显示前的生命周期方法
  async aboutToAppear(){
    let userPreference : string | undefined;
    // 获取存储的用户登录信息
    userPreference = await PreferencesUtil.getPreferenceValue('app', 'Login') as string|undefined;
    // 根据用户登录信息请求用户详情
    let rp2: userRes = await getPhone(userPreference || '');
    // 更新用户信息
    this.user = rp2.data;
  }

  build() {
    // 页面构建
    Scroll() {
      Column({ space: 10 }) {
        // 个人信息部分
        Row() {
          // 显示用户头像
          Image(URL + this.user.photo)
            .width(48)
            .height(48)
          Column() {
            // 显示用户名
            Text(this.user.username + '>')
              .fontSize(20)
          }
          .margin({ left: 10 })
          .alignItems(HorizontalAlign.Start)
        }.onClick(() => {
          // 用户头像点击事件，跳转到个人详情页面
          router.pushUrl({
            url: "pages/MindPage",
            params: {
              data: this.user
            }
          })
        })
        .margin({ top: 100 })
        .width('100%')
        .padding({ left: 20, bottom: 10 })
        .borderRadius(16)

        // 用户等级和小幸运部分
        Row() {
          Column() {
            // 显示用户等级
            Text('LV.0小迷鹿')
              .fontSize(15)
            Row({ space: 150 }) {
              // 显示积分（例如：0）
              Text('0')
                .fontSize(25)
                .margin({ top: 15 })
              // 显示激励文字
              Text("去喝一杯，加入瑞小幸！>")
                .fontSize(14)
                .fontColor(Color.Gray)
                .textAlign(TextAlign.End)
            }
            // 显示一条分隔线
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
        .margin({ left: 20, right: 20 })
        .borderRadius(16)

        // 功能列表部分
        Row({ space: 25 }) {
          // 我的订单功能
          Column() {
            Image($r('app.media.mine_1'))
              .width(42)
              .height(42)
            Text("我的订单")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 5 })
          }.onClick(() => {
            // 点击事件跳转到订单页面
            router.pushUrl({
              url: "pages/OrderPage"
            })
          })
          // 咖啡钱包功能
          Column() {
            Image($r('app.media.mine_2'))
              .width(42)
              .height(42)
            Text("咖啡钱包")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 5 })
          }
          // 优惠券功能
          Column() {
            Image($r('app.media.mine_3'))
              .width(42)
              .height(42)
            Text("优惠券")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 5 })
          }
          // 招商加盟功能
          Column() {
            Image($r('app.media.mine_4'))
              .width(42)
              .height(42)
            Text("招商加盟")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 5 })
          }
          // 账户余额功能
          Column() {
            Image($r('app.media.mine_5'))
              .width(42)
              .height(42)
            Text("账户余额")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 5 })
          }
        }.width("90%")
        .margin({ top: 10, bottom: 10 })
        .justifyContent(FlexAlign.Center)

        // 小幸运部分
        Row() {
          Image($r('app.media.pic_6'))
        }
        .alignItems(VerticalAlign.Center)
        .width('90%')
        .height(96)
        .backgroundColor(Color.White)
        .margin({ top: 20, left: 20, right: 20, bottom: 20 })
        .borderRadius(16)

        // 我的幸运部分
        Row() {
          // 显示标题“我的小幸运”
          Text("我的小幸运").fontSize(18).fontWeight(FontWeight.Bold).align(Alignment.Start)
        }.margin({ left: 20, right: 20, bottom: 5 })
        .justifyContent(FlexAlign.Start)

        // 另一张图片
        Row() {
          Image($r('app.media.pic_12'))
        }
        .alignItems(VerticalAlign.Center)
        .width('90%')
        .height(96)
        .backgroundColor(Color.White)
        .margin({ left: 20, right: 20 })
        .borderRadius(16)

        // 空白区域
        Blank()

        // 退出登录按钮
        Button('退出登录', { type: ButtonType.Capsule })
          .width('90%')
          .height(40)
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .backgroundColor("#212773")
          .margin({ bottom: 150 })
          .onClick(() => {
            // 退出登录时显示提示
            promptAction.showToast({ message: '退出登录' })
            // 跳转到登录页面
            router.replaceUrl({ url: 'pages/Login' })
          })
      }
      .height('100%')
    }.backgroundColor('#EEEEEE')
  }
}

// Spacer组件，用于占位
interface SpacerProps {
  flex: number;
}
function Spacer(props: SpacerProps) {
  throw new Error('Function not implemented.');
}
