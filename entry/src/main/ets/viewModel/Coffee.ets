@Observed
export class coffee { // 注意：类名首字母大写是常见的命名约定
  resourcestr: string;
  resourcestr2: string;
  title: string;
  title2: string;
  title3: string;
  price: number;
  discountprice: number;
  price1: number;

  constructor(
    resourcestr?: string,
    resourcestr2?: string,
    title?: string,
    title2?: string,
    title3?: string,
    price?: number,
    discountprice?: number,
    price1?: number
  ) {
    // 使用 nullish coalescing operator (??) 提供默认值
    this.resourcestr = resourcestr ?? '';
    this.resourcestr2 = resourcestr2 ?? '';
    this.title = title ?? '';
    this.title2 = title2 ?? '';
    this.title3 = title3 ?? '';
    this.price = price ?? 0;
    this.discountprice = discountprice ?? 0;
    this.price1 = price1 ?? 0;

  }
}