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

  }
}