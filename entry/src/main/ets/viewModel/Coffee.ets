@Observed
export class coffee{
  resourcestr:string
  resourcestr2:string
  title:string
  title2:string
  title3:string
  price:number
  discountprice:number
  price1:number

  constructor(resourcestr?: string,
              resourcestr2?: string,
              title?: string,
              title2?: string,
              title3?: string,
              price?: number,
              discountprice?:number,
              price1?:number
  ) {
    this.resourcestr = resourcestr
    this.resourcestr2 = resourcestr2
    this.title = title
    this.title2 = title2
    this.title3 = title3
    this.price = price
    this.discountprice = discountprice
    this.price1 = price1
  }
}