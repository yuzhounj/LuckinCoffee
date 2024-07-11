import requestUtil from '../utils/request';
import { Order } from '../viewModel/Order';
import { ShopCar } from '../viewModel/ShopCar';
import { user } from '../viewModel/user';


export function saveLuckinShopcar(Shop:ShopCar) {
  return requestUtil.post(`/saveLuckinShopcar`,Shop)
}

export function AddLuckinShopcar(id:number,sum:number) {
  return requestUtil.post(`/AddLuckinShopcar/${id}/${sum}`)
}

export function SubLuckinShopcar(id:number,sum:number) {
  return requestUtil.post(`/SubLuckinShopcar/${id}/${sum}`)
}

export function getLuckinShopcar() {
  return requestUtil.get(`/getLuckinShopcarList`)
}

export function saveLuckinOrde(order:Order) {
  return requestUtil.post(`/saveLuckinOrde`,order)
}

export function getLuckinGoodsList(i:number) {
  return requestUtil.get(`/getLuckinGoodsList/${i}`)
}

export function getTopGoodsList() {
  return requestUtil.get(`/getTopGoodsList`)
}

export function getLuckinOrdeList(phone:string) {
  return requestUtil.get(`/getLuckinOrdeList/${phone}`)
}

export function LoginUser(phone:string,password:string){
  return requestUtil.get(`/LoginUser/${phone}/${password}`)
}

export function SaveUser(user:user){
  return requestUtil.post(`/SaveUser`,user)
}

export function getPhone(id:string){
  return requestUtil.get(`/phone/${id}`)
}

export function deleteOrder(id:number){
  return requestUtil.delete(`/deleteOrder/${id}`)
}

export function deleteLuckinShopcar(id:number){
  return requestUtil.delete(`/deleteLuckinShopcar/${id}`)
}

export function removeLuckinShopcar(){
  return requestUtil.get(`/removeLuckinShopcar`)
}

export function removeLuckinShopcarById(id:number){
  return requestUtil.get(`/removeLuckinShopcar/${id}`)
}



