import router from '@ohos.router';
import PreferencesUtil from '../utils/PreferencesUtil';
import { Address, addressList } from '../viewModel/Address'
@Preview
@Entry
@Component
struct AddressPage {
  @State address:Address[] = [];
  aboutToAppear(){
    this.address = addressList;
  }
  build() {
    List(){
      ListItem(){
        Column(){
          Row(){
            Text('<').position({x:20,y:20}).width(30).height(30).borderRadius(30)
              .textAlign(TextAlign.Center).fontColor(Color.Black)
              .fontSize(30)
              .onClick(()=>{
                router.back()
              })
              Row(){
                Text('门店自提').width(100)
                  .height(30)
                  .textAlign(TextAlign.Center)
                  .fontSize(18)
                  .borderRadius({topLeft:30,bottomLeft:30})
                  .fontColor(Color.White)
                  .backgroundColor('#0022AA')
                Text('送货上门').width(100)
                  .height(30)
                  .textAlign(TextAlign.Center)
                  .fontSize(18)
                  .borderRadius(30)
                  .fontColor('#484848')
                  .backgroundColor('#F6F6F6')
                  .borderRadius({topRight:30,bottomRight:30})
              }.margin({top:10})
          }.width('100%').height(60)
          .justifyContent(FlexAlign.Center)
          Column(){
            Text('附近').fontSize(22).fontWeight(500).margin({top:15,left:15})
            Divider().width(20).height(15)
              .strokeWidth(4).color('#333999')
              .margin({top:2,left:25})
            Column(){
              ForEach(this.address,(item:Address)=>{
                Column(){
                  Text(item.address)
                  Row(){
                    Text(item.distance +' | '+ item.location)
                      .margin({top:7}).fontColor('#9F9F9F')
                  }.width('100%')
                  Text(item.time).margin({top:7})
                    .fontColor('#9F9F9F')
                }
                .width('100%')
                .padding(15)
                .justifyContent(FlexAlign.Start)
                .alignItems(HorizontalAlign.Start)
                .backgroundColor(item.isColor ? '#F5F6FB':'#FFFFFF')
                .onClick(async ()=>{
                  await PreferencesUtil.putPreference('app','address',item.address)
                  router.back()
                })

              })
            }
          }.width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }.width('100%').height('100%')
      }
    }
  }
}