@Observed
export class ShopCar {
  id: number;
  resourcestr: string;
  title: string;
  price: number;
  price2: number = 9.99; // Set a fixed value for price2 here.
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
    // Provide default values for all properties that are not guaranteed to be defined.
    this.id = id ?? 0;
    this.resourcestr = resourcestr ?? '';
    this.title = title ?? '';
    this.price = price ?? 0;
    // No need to set price2 here as it has been given a fixed value in the property declaration.
    this.user = user ?? '';
    this.sum = sum ?? 0;
    this.cupshaped = cupshaped ?? '';
    this.brix = brix ?? '';
    this.temperature = temperature ?? '';
  }
}