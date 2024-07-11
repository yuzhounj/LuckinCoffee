@Observed
export class ShopCar{
  id:number
  resourcestr:string
  title:string
  price:number
  price2:number
  user:string
  sum:number
  cupshaped:string
  brix:string
  temperature:string

  constructor(resourcestr?: string,
              title?: string,
              id?: number,
              price?: number,
              user?:string,
              sum?:number,
              cupshaped?:string,
              brix?:string,
              temperature?:string,
  ) {
    this.resourcestr = resourcestr
    this.title = title
    this.price = price
    this.id = id
    this.user = user
    this.sum = sum
    this.cupshaped = cupshaped
    this.brix = brix
    this.temperature = temperature
  }
}