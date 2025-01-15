@Observed
export class Address {
  address: string;
  distance: string;
  location: string;
  time: string;
  isColor: boolean;

  constructor(
    address?: string,
    distance?: string,
    location?: string,
    time?: string,
    isColor?: boolean,
  ) {
    this.address = address ?? '';
    this.distance = distance ?? '';
    this.location = location ?? '';
    this.time = time ?? '';
    this.isColor = isColor ?? false;
  }
}

export const addressList: Address[] =[
  new Address('北京五道口店','距离你350米','海淀区成府路28号五道口购物中心B1层B101号','08:30-21:00',true),
  new Address('北京奥林匹克公园店','距离你390米','朝阳区北辰东路8号奥林匹克公园中心区N3区A栋1层','09:00-21:00',false),
  new Address('北京三里屯太古里店','距离你450米','朝阳区三里屯路19号三里屯太古里南区1层S101号','08:00-22:00',false),
  new Address('北京国贸店','距离你480米','朝阳区建国门外大街1号国贸商城B1层B110号','07:00-21:30',false),
  new Address('北京西单大悦城店','距离你520米','西城区西单北大街131号大悦城购物中心B1层A11号','08:00-22:00',false),
  new Address('北京金融街购物中心店','距离你580米','西城区金融大街18号金融街购物中心B1层B108号','08:00-22:00',false),
  new Address('北京中关村店','距离你600米','海淀区中关村大街15号中关村广场购物中心B2层B210号','08:00-21:00',false),
  new Address('北京新中关购物中心店','距离你640米','海淀区中关村大街19号新中关购物中心B1层B103号','07:30-21:30',false),
  new Address('北京望京SOHO店','距离你700米','朝阳区望京街10号望京SOHO塔1层L101号','07:30-21:00',false),
  new Address('北京颐堤港店','距离你720米','朝阳区酒仙桥路18号颐堤港购物中心1层L109号','08:00-22:00',false),
]