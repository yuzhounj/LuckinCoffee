import router from '@ohos.router'
import { SaveUser } from '../api/api'
import { showToast } from '../utils/toast'
import { user } from '../viewModel/user'
interface RouterParams {
  phone: string;
  password: string;
}

interface stringRes {
  data: string
}
interface userRes {
  data:user
}
@Entry
@Component
struct Register {
  @State user: user = new user()
  @State isGreen: boolean = true
  @State isLoading: boolean = false
  @State password1:string = '123'
  @State start:string = ''

  @State select: number = 0
  private fruits: string[] = ['男', '女']

  aboutToAppear() {
    this.user.phone = ''
    this.user.username = ''
    this.user.gender = '男'
    this.user.password = ''
    this.isGreen = false
  }
  build() {
    Column() {
      Column({ space: 15 }) {
        Text('注册')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
        Text('欢迎注册')
          .opacity(0.5)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.Start)
      .padding(20)
      .margin({ bottom: 30 })
      Column({ space: 10 }) {

        Row({ space: 10 }) {
          Image($r('app.media.icon_luckin'))
            .width(25)
            .height(25)
          Row() {}
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)
          TextInput({ text: this.user.username, placeholder: '请输入用户名' })
            .maxLength(15)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.user.username = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })

        /* 手机号 */
        Row({ space: 10 }) {
          Image($r('app.media.phone'))
            .width(25)
            .height(25)
          Row() {}
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)
          TextInput({ text: this.user.phone, placeholder: '请输入手机号' })
            .maxLength(15)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.user.phone = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })
        .margin({ top: 10 })

        // 密码
        Row({ space: 10 }) {
          Image($r('app.media.code'))
            .width(25)
            .height(25)
          Row() {}
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)
          TextInput({ text: `${this.user.password}`, placeholder: '请输入密码' })
            .maxLength(15)
            .type(InputType.Password)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.user.password = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })
        .margin({ top: 10 })

        // 再次输入密码
        Row({ space: 10 }) {
          Image($r('app.media.code'))
            .width(25)
            .height(25)
          Row() {}
          .width(1)
          .height(25)
          .backgroundColor('#000')
          .opacity(0.2)
          TextInput({ text: `${this.password1}`, placeholder: '请再次输入密码' })
            .maxLength(15)
            .type(InputType.Password)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onChange(value => this.password1 = value)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })
        .margin({ top: 10 })

        Row({ space: 10 }) {
          Row({ space: 10 }){
            Image($r('app.media.code'))
              .width(25)
              .height(25)
            Row() {}
            .width(1)
            .height(25)
            .backgroundColor('#000')
            .opacity(0.2)
          }

          TextInput({ text: `${this.user.gender}`, placeholder: '请输入性别' })
            .maxLength(15)
            .copyOption(CopyOptions.LocalDevice)
            .layoutWeight(1)
            .height(50)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .padding(0)
            .onClick(() => {
              TextPickerDialog.show({
                range: this.fruits,
                selected: this.select,
                onAccept: (value: TextPickerResult) => {
                  // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                  console.log(this.user.gender)
                 if(typeof value.index === 'number'){this.select = value.index;}
                  console.log(this.fruits[this.select])

                  this.user.gender = this.fruits[this.select]
                  console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
                },
                onCancel: () => {
                  console.info("TextPickerDialog:onCancel()")
                },
                onChange: (value: TextPickerResult) => {
                  console.info("TextPickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fff')
        .borderRadius(15)
        .padding({ left: 15, right: 15 })
        .margin({ top: 10 })
        .justifyContent(FlexAlign.SpaceBetween)


        Row() {
          Checkbox()
            .width(13)
            .height(13)
            .select(this.isGreen)
            .onChange(value => this.isGreen = value)
          Text('我已阅读并同意')
            .fontSize(12)
            .fontColor('#9C9BAB')
          Text('《用户注册服务条款》')
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
        .margin({ top: 20 })
        /* 登录按钮 */
        Button('注册')
          .width('100%')
          .backgroundColor('#5677FC')
          .onClick(async () => {
            const regex = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
            if(this.user.phone === '' || !regex.test(this.user.phone)) {
              showToast('手机号不合法', 2000)
              return
            }
            if(this.user.password === '') {
              showToast('密码不能为空', 2000)
              return
            }
            if(this.password1 === '') {
              showToast('请再次输入密码', 2000)
              return
            }
            if(this.user.password !== this.password1) {
              showToast('密码输入不一致', 2000)
              return
            }
            if(this.user.gender === ''){
              showToast('请选择性别',2000)
              return
            }
            if(this.isGreen === false) {
              showToast('请先同意条款', 2000)
              return
            }
            console.log(this.user.gender)
            let rp:stringRes = await SaveUser(this.user)
            this.start = rp.data
            if(this.start === "ok"){
              showToast('注册成功', 2000)
              console.log("user:"+this.user)
              setTimeout(() => {
                router.replaceUrl({
                  url: 'pages/Login',
                  params:{
                    phone:this.user.phone,
                    password:""
                  }
                }, router.RouterMode.Single)
              }, 2000)
            }else{
              showToast('注册失败',2000)
              setTimeout(()=>{
                this.isGreen = false
              })
            }
          })
        Text('返回登录')
          .fontSize(15)
          .opacity(0.8)
          .margin({ top: 10 })
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Login',
              // params:{
              //   phone:"",
              //   password:""
              // }
            }, router.RouterMode.Single)
          })
        if(this.isLoading === true) {
          LoadingProgress()
            .color(Color.Gray)
            .width(60)
            .height(60)
            .margin({ top: 30, bottom: 30 })
        }
      }
      .width('100%')
      .padding({ left: 25, right: 25 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F5F9')
  }
}
