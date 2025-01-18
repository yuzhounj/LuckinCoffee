import { user } from "./user";

@Observed
export class ShopCar {
  id: number;
  resourcestr: string;
  title: string;
  price: number;
  price2: number = 9.99;
  user: string;
  sum: number;
  cupshaped: string;
  brix: string;
  temperature: string;

  constructor(
    resourcestr?: string,
    title?: string,
    id?: number,
    price?: number,
    user?: string,
    sum?: number,
    cupshaped?: string,
    brix?: string,
    temperature?: string,
  ) {
    this.id = id ?? 0;
    this.resourcestr = 'app.media.bottom1';
    this.title = title ?? '';
    this.price = price ?? 0;
    this.user = user??'';
    this.sum = sum ?? 0;
    this.cupshaped = cupshaped ?? '';
    this.brix = brix ?? '';
    this.temperature = temperature ?? '';
  }
}