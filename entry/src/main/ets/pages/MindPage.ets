import router from '@ohos.router'  // 引入路由功能
import { getPhone } from '../api/api'  // 引入获取手机号码的 API
import { URL } from '../utils/request'  // 引入请求的基础 URL
import { user } from '../viewModel/user'  // 引入用户视图模型

// 定义 RouterParams 接口，包含用户数据
interface RouterParams {
  data:user  // 用户数据
}

@Entry  // 页面入口标识
@Preview  // 预览标识
@Component  // 组件装饰器
export struct MindPage {
  @State user:user = new user()  // 声明一个 user 状态，初始值为 user 类的一个实例

  // 页面即将显示时的钩子函数
  async aboutToAppear(){
    let t:RouterParams = router.getParams() as RouterParams  // 获取路由传递的参数
    this.user = t.data  // 将路由参数中的用户数据赋值给当前组件的 user 状态
  }

  // 构建页面布局
  build() {
    Column(){  // 主容器：垂直排列布局
      Row(){  // 水平布局
        Text('<')  // 返回箭头
          .position({x:0,y:0})  // 设置文本位置
          .width(30).height(30)  // 设置文本的宽高
          .fontSize(25)  // 设置字体大小
          .textAlign(TextAlign.Center)  // 设置文本居中对齐
          .onClick(()=>{  // 点击事件
            router.back()  // 返回上一级页面
          })
        Text('个人资料')  // 显示 "个人资料" 字样
          .fontWeight(500)  // 设置字体加粗
          .fontSize(23)  // 设置字体大小
      }.width('100%')  // 设置行宽度为 100%
      .justifyContent(FlexAlign.Center)  // 水平居中
      .padding(15)  // 设置内边距
      Column(){  // 垂直排列的列布局
        // 头像
        Row(){
          Text('头像').fontColor('#696969')  // 文字 "头像"，设置字体颜色为灰色
          Row(){  // 内部水平布局
            Image(URL+this.user.photo)  // 显示用户头像，URL 是基础路径，this.user.photo 是头像文件名
              .width(45).height(45)  // 设置图片宽高
              .borderRadius(30)  // 设置圆角
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左侧间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')  // 设置宽度为 100%
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(80)  // 设置高度

        // 用户名
        Row(){
          Text('用户名').fontColor('#696969')  // "用户名" 字样，设置颜色为灰色
          Row(){
            Text(this.user.username)  // 显示用户名
              .fontSize(14)  // 设置字体大小
              .fontColor('#383838')  // 设置字体颜色为深灰色
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

        // 性别
        Row(){
          Text('性别').fontColor('#696969')  // "性别" 字样，设置颜色为灰色
          Row(){
            Text(this.user.gender)  // 显示性别
              .fontSize(14)  // 设置字体大小
              .fontColor('#383838')  // 设置颜色为深灰色
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左侧间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

        // 手机号
        Row(){
          Text('关联手机号').fontColor('#696969')  // "关联手机号" 字样，设置颜色为灰色
          Row(){
            Text(this.user.phone)  // 显示手机号
              .fontSize(14)  // 设置字体大小
              .fontColor('#383838')  // 设置颜色为深灰色
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左侧间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

      }.width('95%')  // 设置该列的宽度为 95%
      .borderRadius(3)  // 设置圆角
      .padding(15)  // 设置内边距
      .backgroundColor(Color.White)  // 设置背景色为白色

      // 账号管理部分
      Column(){
        Row(){
          Text('账号管理').fontColor('#696969')  // "账号管理" 字样，设置颜色为灰色
          Row(){
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

        // 免密支付
        Row(){
          Text('免密支付').fontColor('#696969')  // "免密支付" 字样，设置颜色为灰色
          Row(){
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

        // 通用设置
        Row(){
          Text('通用设置').fontColor('#696969')  // "通用设置" 字样，设置颜色为灰色
          Row(){
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

        // 协议与说明
        Row(){
          Text('协议与说明').fontColor('#696969')  // "协议与说明" 字样，设置颜色为灰色
          Row(){
            Text('>')  // 显示 ">"
              .margin({left:10})  // 设置左间距
              .fontSize(18)  // 设置字体大小
              .fontColor('#DDDDDD')  // 设置字体颜色为浅灰色
          }
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)  // 水平两端对齐
        .height(50)

      }.width('95%')  // 设置该列的宽度为 95%
      .borderRadius(3)  // 设置圆角
      .margin({top:10})  // 设置顶部外边距
      .padding(15)  // 设置内边距
      .backgroundColor(Color.White)  // 设置背景色为白色

    }.width('100%')  // 主容器的宽度为 100%
    .height('100%')  // 主容器的高度为 100%
    .backgroundColor('#F6F6F6')  // 设置背景色为浅灰色
  }
}
