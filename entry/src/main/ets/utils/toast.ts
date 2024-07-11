import promptAction from '@ohos.promptAction'
export function showToast(message, duration) {
    promptAction.showToast({
        message,
        duration
    })
}