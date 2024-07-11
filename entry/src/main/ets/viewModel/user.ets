@Observed
export class user{
  username:string
  phone: string
  photo: string
  gender: string
  password: string

  constructor(username?: string, phone?: string,photo?:string,gender?:string,password?:string) {
    this.username = username
    this.phone = phone
    this.photo = photo
    this.gender = gender
    this.password = password
  }
}