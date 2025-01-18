import axios from '@ohos/axios'
export const URL = 'http://192.168.10.3:8080'
const requestUtil = axios.create({
  baseURL: 'http://192.168.10.3:8080',
  timeout: 5000,
  headers: {
    "Content-Type": "application/json"
  }
})
requestUtil.interceptors.request.use(config => {
  const token = AppStorage.Link('token')
  if(token !== undefined) {
    config.headers.Authorization = token.get()
  }
  return config
})
requestUtil.interceptors.response.use(response => {
  if (response.status !== 200) {
    console.log('testTag', 'response.status')
    return Promise.reject(response)
  }
  const data = response.data
  console.log('testTag', JSON.stringify(data))
  if(data.code !== 200) {
    return Promise.reject(new Error(data.msg || '操作失败'))
  }
  return data
}, err => {
  return Promise.reject(err)
})

export default requestUtil
