class DateUtil {

  formatDateTime(num: number): string {
    let date = new Date(num);
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hours = date.getHours();
    let minutes = date.getMinutes();

    let m = month < 10 ? '0' + month : month;
    let d = day < 10 ? '0' + day : day;
    let h = hours < 10 ? '0' + hours : hours;
    let min = minutes < 10 ? '0' + minutes : minutes;

    return `${year}-${m}-${d} ${h}:${min}`;
  }

  beginTimeOfDay(date: Date) {
    let d = new Date(date.getFullYear(), date.getMonth(), date.getDate(),date.getHours(),date.getMinutes());
    return d.getTime();
  }
}

let dateUtil = new DateUtil();

export default dateUtil as DateUtil;
