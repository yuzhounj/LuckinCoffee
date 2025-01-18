import requestUtil from '../utils/request';
import { Order } from '../viewModel/Order';
import { ShopCar } from '../viewModel/ShopCar';
import { user } from '../viewModel/user';
import {resInfo}from '../viewModel/resInfo';

export function saveLuckinShopcar(Shop:ShopCar) {
  return requestUtil.post(`/shop/save`,Shop)
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

export function LoginUser(info:resInfo){
  return requestUtil.post(`/login`,info)
}

export function SaveUser(user:user){
  return requestUtil.post(`/register`,user)
}

export function getPhone(phone:string){
  return requestUtil.post(`/getUserByPhone`,phone)
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



