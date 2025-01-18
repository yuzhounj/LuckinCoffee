// 引入路由、API、日期工具等模块
import router from '@ohos.router'
import { getLuckinShopcar, removeLuckinShopcar, removeLuckinShopcarById, saveLuckinOrde } from '../api/api';
import DateUtil from '../utils/DateUtil';
import PreferencesUtil from '../utils/PreferencesUtil';
import { URL } from '../utils/request';
import { showToast } from '../utils/toast';
import { Address, addressList } from '../viewModel/Address';
import { Order } from '../viewModel/Order';
import { ShopCar } from '../viewModel/ShopCar';

// 定义返回的购物车数据结构
interface LuckinShopcarResponse {
  data: ShopCar[];
}

// 定义路由传递的参数
interface RouterParams {
  is: boolean;
  data: ShopCar;
}

// 页面组件声明，入口与预览标注
@Entry
@Preview
@Component
export struct payPage {

  // 定义各个状态变量
  @State car: ShopCar[] = []          // 购物车商品列表
  @State money: number = 0;           // 总应付金额
  @State money1: number = 0;          // 总优惠金额
  @State isCar: boolean = true        // 判断是否是从购物车跳转

  @State address: Address = new Address()    // 用户地址信息
  @State address1: Address[] = []            // 地址列表
  @State isAddress: boolean = true           // 是否使用自定义地址
  @State userPhone: string = ''              // 用户电话号码
  @State address2: string = ''               // 备用地址字段

  // 页面显示时，加载存储的用户地址与登录信息
  async onPageShow() {
    let i = await PreferencesUtil.getPreferenceValue('app', 'address') as string | undefined
    let phone = await PreferencesUtil.getPreferenceValue('app', 'Login') as string | undefined
    this.userPhone = phone || ''
    this.address1 = addressList

    if (i !== undefined && i !== null) {
      this.isAddress = false
      this.address = this.address1.filter(item => item.address == i)[0]
    }
  }

  // 页面即将显示时，根据路由参数加载购物车信息或单个商品信息
  async aboutToAppear() {
    let t = router.getParams() as RouterParams;
    this.isCar = t.is;

    // 如果是从购物车跳转，获取购物车数据
    if (this.isCar) {
      let response: LuckinShopcarResponse = await getLuckinShopcar()
      this.car = response.data
      for (let i = 0; i < this.car.length; i++) {
        this.money = (this.money + this.car[i].price) * this.car[i].sum
        this.money1 = (this.money1 + this.car[i].price2) * this.car[i].sum
      }
    } else {
      // 如果是从单个商品跳转，添加商品到购物车
      this.car.push(t.data)
      this.money = (this.money + this.car[0].price) * this.car[0].sum
      this.money1 = (this.money1 + this.car[0].price2) * this.car[0].sum
    }
  }

  // 构建页面UI
  build() {
    Column() {
      List() {
        ListItem() {
          Column() {
            // 返回按钮与标题
            Row() {
              Text('<').position({ x: 0, y: 0 }).width(30).height(30).fontSize(25)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  router.back()  // 点击返回按钮返回上一页面
                })
              Text('确认订单').fontWeight(500).fontSize(23)
            }.width('100%').justifyContent(FlexAlign.Center)
            .padding(15)

            // 地址信息显示与点击选择地址
            Row() {
              Column() {
                Text(this.isAddress ? '北京中央广场店 >' : `${this.address.address} >`).fontSize(15)
                Text(this.isAddress ? '红谷滩区红谷中大道998号绿地中央广场峰创国际一层大堂' : `${this.address.location}`).margin({ top: 5 }).fontSize(13).fontColor('#797979')
              }.width(200).justifyContent(FlexAlign.Start).height(70).alignItems(HorizontalAlign.Start)
              .padding(10)
              .onClick(() => {
                router.pushUrl({
                  url: "pages/AddressPage"  // 跳转到地址选择页面
                })
              })
              Row() {
                Text(' 自提 ').backgroundColor('#343A9F').borderRadius(30).fontColor('#DFE1EC')
                Text(' 外卖 ').fontColor('#A1A1A1')
              }.backgroundColor('#F6F6F6').borderRadius(30)
              .height(25).margin({ right: 10 })
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .height(100).backgroundColor(Color.White).borderRadius(15).margin({ bottom: 20 })

            // 店员信息与提示
            Row() {
              Column() {
                Text('立即自取，约09:40可取').fontSize(15)
                Text('金牌咖啡师正在等你下单').margin({ top: 5 }).fontSize(13).fontColor('#797979')
              }.width(200).justifyContent(FlexAlign.Start).height(70).alignItems(HorizontalAlign.Start)
              .padding(10)
              Row() {
                Image($r('app.media.kfs'))
                  .width(50).height(50)
              }.backgroundColor('#F6F6F6').borderRadius(30)
              .height(25).margin({ right: 10 })
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .height(100).backgroundColor(Color.White).borderRadius(15).margin({ bottom: 20 })

// <<<<<<< HEAD
//             Column(){
//               ForEach(this.car,(item:ShopCar)=>{
//                 Row(){
//                   Row(){
//                     Image($r(item.resourcestr)).width(80).height(80)
//                     Column(){
// =======
            // 显示购物车商品列表
            Column() {
              ForEach(this.car, (item: ShopCar) => {
                Row() {
                  Row() {
                    Image(URL + item.resourcestr).width(80).height(80)
                    Column() {
// >>>>>>> c7b805bd7fc9c3cbd7014c1585560eca89240604
                      Text(item.title)
                        .margin({ bottom: 10 }).fontWeight(500).fontColor(Color.Black)
                      Text(item.temperature + '/' + item.brix)
                        .margin({ bottom: 10 }).fontSize(14).fontColor('#A7A7A9')
                      Text('商品直减').borderWidth(1).borderColor('#EDC1BF')
                        .fontColor('#D7694F').padding(3)
                    }.margin({ left: 10 }).width(100).justifyContent(FlexAlign.Start)
                    .alignItems(HorizontalAlign.Start)
                  }
                  Column() {
                    Row() {
                      Text('￥').fontSize(15).fontColor('#F05835')
                      Text(item.price.toFixed(1)).fontSize(22).fontWeight(600).fontColor('#F05835')
                        .margin({ top: -5 })
                    }
                    .margin({ bottom: 10 })
                    Text('￥' + item.price2.toFixed(0)).fontColor('#A4A5A9')
                      .decoration({
                        type: TextDecorationType.LineThrough,
                        color: '#A4A5A9'
                      }).fontSize(15).margin({ bottom: 10 })
                    Text('x' + item.sum)
                      .fontWeight(500)
                      .fontSize(12)
                      .fontColor('#888888')
                  }.width('150')
                  .margin({ left: 15 })

                }.margin({ top: 5 })
                .width('100%').padding(15)
              })
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({ bottom: 20 })

            // 支付方式与选择
            Row() {
              Text('支付方式')
              Text('微信支付 >')
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({ bottom: 20 })
            .height(60).padding(15)

            // 取餐方式选择
            Row() {
              Text('取餐方式')
              Row() {

                // 单选框选择
                Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
                  .height(15)
                  .width(15)
                  .onChange((isChecked: boolean) => {
                    console.log('Radio1 status is ' + isChecked)
                  })
                  .borderColor('#E1D2BE')
                Text('店内用餐').fontSize(14)

                Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
                  .height(15)
                  .width(15)
                  .onChange((isChecked: boolean) => {
                    console.log('Radio1 status is ' + isChecked)
                  })
                  .borderColor('#E1D2BE')
                Text('自提带走').fontSize(14)

              }
            }.width('93%').justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White).borderRadius(15).margin({ bottom: 20 })
            .height(60).padding(15)

          }.height(1000)
        }
      }

      // 底部应付金额与支付按钮
      Row() {
        Column() {
          Row() {
            Text('应付 ')
            Text('￥' + this.money.toFixed(2)).fontSize(23).fontWeight(500)
          }.margin({ top: 5 })
          Row() {
            Text('总计优惠￥' + (this.money1 - this.money).toFixed(2)).fontColor('#F9613F')
          }.margin({ top: 5 })
        }.width('50%').padding(15).justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
        Button('去支付')
          .width(120)
          .height(45)
          .margin({ right: 15 })
          .backgroundColor('#F95731')
          .onClick(async () => {
            showToast(`支付成功！共支付${this.money}`, 2000)  // 支付成功提示
            for (let index = 0; index < this.car.length; index++) {
              // 遍历购物车商品，创建订单并保存
              let order: Order = new Order()
              order.sum = this.car[index].sum
              order.resourcestr = this.car[index].resourcestr
              order.title = this.car[index].title
              order.price = this.car[index].price
              order.money = this.car[index].price * this.car[index].sum
              order.user = this.userPhone
              order.brix = this.car[index].brix
              order.temperature = this.car[index].temperature
              order.cupshaped = this.car[index].cupshaped
              order.address = this.isAddress ? '北京中央广场店' : this.address.address
              order.time = DateUtil.formatDateTime(DateUtil.beginTimeOfDay(new Date()))
              await saveLuckinOrde(order)  // 保存订单
              await removeLuckinShopcarById(this.car[index].id).catch().finally()  // 清除购物车
            }
            router.replaceUrl({
              url: "pages/Index",  // 跳转到首页
              params: {
                typeIndex: 1
              }
            })
          })

      }.width('100%').backgroundColor(Color.White).height(90)
      .position({ x: 0, y: '89%' }).justifyContent(FlexAlign.SpaceBetween)
    }.backgroundColor('#F5F5F5')
  }
}
