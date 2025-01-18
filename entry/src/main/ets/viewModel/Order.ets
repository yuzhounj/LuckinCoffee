@Observed
export class Order {
  id:number
  resourcestr:string
  title:string
  price:number
  user:string
  sum:number
  cupshaped:string
  brix:string
  temperature:string
  money:number
  address:string
  time:string

  constructor(resourcestr?: string,
              title?: string,
              id?: number,
              price?: number,
              user?:string,
              sum?:number,
              cupshaped?:string,
              brix?:string,
              temperature?:string,
              money?:number,
              address?:string,
              time?:string,
  ) {
    this.resourcestr = 'app.media.bottom1'
    this.title = title|| ''
    this.price = price|| 0
    this.user = user||''
    this.sum = sum||0
    this.cupshaped = cupshaped||''
    this.brix = brix||''
    this.temperature = temperature||''
    this.money = money||0
    this.address = address||''
    this.time = time||''
    this.id = id||0
  }
}