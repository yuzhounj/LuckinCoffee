import router from '@ohos.router';  // 导入路由模块，用于页面跳转
import { deleteOrder, getLuckinOrdeList } from '../api/api';  // 导入删除订单和获取订单列表的API方法
import PreferencesUtil from '../utils/PreferencesUtil';  // 导入偏好设置工具类，用于获取本地存储的用户登录状态
import { URL } from '../utils/request';  // 导入基础的请求URL
import { Order } from '../viewModel/Order';  // 导入订单的数据模型

interface orderL {  // 定义一个接口，用于表示从API获取的订单列表结构
  data: Order[];  // 订单列表，包含多个订单对象
}

@Entry  // 表示这是一个页面入口
@Preview  // 表示此组件可以预览
@Component  // 定义组件
struct OrderPage {
  @State order: Order[] = [];  // 定义订单列表的状态，初始为空数组

  // 页面即将显示时的生命周期函数
  async aboutToAppear() {
    // 获取用户的登录状态
    let i = await PreferencesUtil.getPreferenceValue('app', 'Login') as string | undefined;
    if (i === undefined) {
      // 用户未登录，不做任何处理
    } else {
      // 如果用户已登录，则通过API获取订单列表
      let rp: orderL = await getLuckinOrdeList(i);
      this.order = rp.data;  // 更新页面状态，显示订单列表
    }
  }

  // 页面构建
  build() {
    // 使用 Column 组件构建垂直布局
    Column() {
      // 顶部导航栏
      Row() {
        // 返回按钮
        Text('<').position({x: 0, y: 0}).width(30).height(30).fontSize(25)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            router.back();  // 点击返回按钮时，返回上一个页面
          });
        // 页面标题
        Text('我的订单').fontWeight(500).fontSize(23);
      }.width('100%').justifyContent(FlexAlign.Center)
      .padding(15);

      // 订单列表
      List() {
        ListItem() {
          Column() {
            // 遍历每个订单
            ForEach(this.order, (item: Order) => {
              Column() {
                // 自提标签和删除按钮
                Row() {
                  Row() {
                    // 自提标签
                    Text('自提').fontSize(14).width(40).height(20).backgroundColor('#C3A077')
                      .textAlign(TextAlign.Center)
                      .borderRadius(5).fontColor(Color.White);
                    Text(item.address).margin({left: 5});  // 显示地址
                  }
                  Row() {
                    // 已完成状态和删除按钮
                    Text('已经完成 | ').fontColor('#9A9A9A').fontSize(14);
                    Image($r('app.media.detele')).width(15).height(15)
                      .onClick(async () => {
                        // 点击删除按钮时，调用删除订单API
                        await deleteOrder(item.id);
                        this.aboutToAppear();  // 删除后重新加载订单列表
                      });
                  }
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                .padding(10)
                .margin({top: 5});

                // 分割线
                Row() {
                  Divider().width('95%').color('#F2F2F2');
                }.width('100%').justifyContent(FlexAlign.Center)
                .margin({top: 10, bottom: 20});

                // 订单详情
                Row() {
                  Row() {
                    // 订单图片
                    Image(URL + item.resourcestr).width(90).height(90);
                    Column() {
                      // 订单标题
                      Text(item.title).fontWeight(700).fontSize(18);
                      // 订单详情：温度、杯型、糖度
                      Text(item.temperature + '/' + item.cupshaped + '/' + item.brix).margin({top: 10})
                        .fontColor('#7C7C7C').fontSize(14).fontWeight(500);
                    }.width(200).alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.Start)
                    .margin({left: 10});
                  }
                  // 显示订单数量
                  Text('x ' + item.sum).fontSize(15).fontColor('#999999').margin({right: 15});
                }.width('100%').padding({left: 15, right: 15})
                .justifyContent(FlexAlign.SpaceBetween);

                // 时间和平台信息
                Row() {
                  Row() {
                    // 订单时间
                    Text(item.time)
                      .fontSize(10)
                      .fontColor('#9E9E9E');
                    // 平台信息
                    Text(' luckin coffee小程序 ')
                      .fontSize(10).backgroundColor('#F2F2F2')
                      .fontColor('#86A9C9')
                      .borderRadius(2)
                      .margin({left: 8});
                  }
                  Row() {
                    // 订单总数和总价
                    Text('共' + item.sum + '件商品 合计:')
                      .fontSize(10);
                    Text('￥' + item.price * item.sum).fontSize(12).fontWeight(600);
                  }
                }.width('100%').margin({top: 20}).padding({left: 10, right: 10})
                .justifyContent(FlexAlign.SpaceBetween);

                // 再来一单按钮
                Row() {
                  Button('再来一单')
                    .backgroundColor('#FFFFFF')
                    .borderWidth(2)
                    .borderColor('#0A2598')
                    .fontColor('#173083')
                    .height(35)
                    .onClick(() => {
                      // 点击按钮时跳转到首页，并传递参数
                      router.replaceUrl({
                        url: "pages/Index",
                        params: {
                          typeIndex: 1,
                        }
                      });
                    });
                }.width('100%').justifyContent(FlexAlign.End)
                .padding({left: 15})
                .margin({top: 10});
              }
              .margin({top: 10})
              .width('95%')
              .borderRadius(7)
              .height(260)
              .backgroundColor(Color.White)
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start);
            });
          }.width('100%').margin({bottom: 10});
        }.backgroundColor('#F6F6F6');
      }.backgroundColor('#F6F6F6').layoutWeight(1);
    }.width('100%')
    .backgroundColor('#F6F6F6');
  }
}
