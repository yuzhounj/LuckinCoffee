@Observed
export class resInfo {

  phone: string;
  password: string;

  constructor(
    phone?: string,
    password?: string
  ) {
    this.phone = phone ?? '';
    this.password = password ?? '';

    // 如果有特定的默认值或业务逻辑，可以在这里添加额外的处理
    // 例如，对密码进行加密等操作
  }
}