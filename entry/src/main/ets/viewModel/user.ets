@Observed
export class user { // 注意：类名首字母大写是常见的命名约定
  username: string;
  phone: string;
  photo: string;
  gender: string;
  password: string;

  constructor(
    username?: string,
    phone?: string,
    photo?: string,
    gender?: string,
    password?: string
  ) {
    // 使用 nullish coalescing operator (??) 提供默认值
    this.username = username ?? '';
    this.phone = phone ?? '';
    this.photo = photo ?? '';
    this.gender = gender ?? '';
    this.password = password ?? '';

    // 如果有特定的默认值或业务逻辑，可以在这里添加额外的处理
    // 例如，对密码进行加密等操作
  }
}