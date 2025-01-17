import router from '@ohos.router'
import { getPhone, LoginUser } from '../api/api'
import PreferencesUtil from '../utils/PreferencesUtil'
import { showToast } from '../utils/toast'
import { user } from '../viewModel/user'
interface RouterParams {
  phone: string;
  password: string;
}
interface stringRes {
  data:string
}
interface userRes {
  data:user
}

@Entry
@Component
struct Login {
  @State phone: string = ""
  @State password: string = ""
  @State ph: string = ""
  @State isGreen: boolean = true
  @State isLoading: boolean = false
  @State start: string = "";
  @State user: user = new user()

  aboutToAppear() {
    let t:RouterParams= router.getParams() as RouterParams
    if (t) {
      this.phone = t.phone ;
      this.password = t.password ;
    }
    this.isGreen = true
  }

  build() {
    Column() {
      Column({ space: 15 }) {
        Text('欢迎回来！')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
        Text('欢迎使用，瑞幸APP')
          .opacity(0.5)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.Start)
      .padding(20)
      .margin({ bottom: 30 })

      Column({ space: 10 }) {
        /* 手机号 */
        Row({ space: 10 }) {
          Image($r('app.media.phone'))
            .width(25)
            .height(25)
          Row() {
          }
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)

          TextInput({ text: this.phone, placeholder: '请输入手机号' })
            .maxLength(15)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.phone = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })

        Row({ space: 10 }) {
          Image($r('app.media.code'))
            .width(25)
            .height(25)
          Row() {
          }
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)

          TextInput({ text: `${this.password}`, placeholder: '请输入密码' })
            .maxLength(15)
            .type(InputType.Password)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.password = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })
        .margin({ top: 10 })

        Row() {
          Text('忘记密码')
            .fontSize(15)
            .opacity(0.8)
        }
        .width('100%')
        .margin({ top: 10 })
        .justifyContent(FlexAlign.End)

        Row() {
          Checkbox()
            .width(13)
            .height(13)
            .select(this.isGreen)
            .onChange(value => this.isGreen = value)
          Text('我已阅读并同意')
            .fontSize(12)
            .fontColor('#9C9BAB')
          Text('《用户服务条款》')
            .fontSize(12)
            .fontColor('#2974C8')
          Text('与')
            .fontSize(12)
            .fontColor('#9C9BAB')
          Text('《隐私政策》')
            .fontSize(12)
            .fontColor('#2974C8')
        }
        .width('100%')
        /* 登录按钮 */
        Button('登录')
          .width('100%')
          .backgroundColor('#5677FC')
          .onClick(async () => {
            const regex = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
            if (this.phone === '' || !regex.test(this.phone)) {
              showToast('手机号不合法', 2000)
              return
            }
            if (this.password === '') {
              showToast('密码不能为空', 2000)
              return
            }
            if (this.isGreen === false) {
              showToast('请先同意条款', 2000)
              return
            }
            let rp:stringRes = await LoginUser(this.phone, this.password)
            this.start = rp.data
            let rp2:userRes = await getPhone(this.phone)
            this.user = rp2.data
            if (this.start === "OK") {
              showToast('登录成功', 2000)
              console.log('phone' + this.user.phone)
              await PreferencesUtil.putPreference('app', 'Login', this.user.phone)
              setTimeout(() => {
                router.replaceUrl({
                  url: 'pages/Index',
                  params: {
                    currentIndex: 0
                  }
                }, router.RouterMode.Single)
              }, 3000)
            } else if (this.start === "ERROR") {
              showToast('密码错误', 2000)
            } else if (this.start === "NO") {
              showToast('暂无账号', 2000)
            }
          })

        Text('暂无账号,立即注册?')
          .fontSize(15)
          .opacity(0.8)
          .margin({ top: 10 })
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Register'
            }, router.RouterMode.Single)
          })
        if (this.isLoading === true) {
          LoadingProgress()
            .color(Color.Gray)
            .width(60)
            .height(60)
            .margin({ top: 30, bottom: 30 })
        }
      }
      .width('100%')
      .padding({ left: 25, right: 25 })

      Column({ space: 30 }) {
        Row({ space: 5 }) {
          Row() {
          }
          .width(80)
          .backgroundColor('#000')
          .opacity(0.8)

          Text('第三方账号登录')
            .fontSize(15)
            .fontColor('#9C9BAB')
          Row() {
          }
          .width(80)
          .backgroundColor('#000')
          .opacity(0.8)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.End)
      .margin({ bottom: 50 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F5F9')
  }
}