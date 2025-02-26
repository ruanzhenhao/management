//设置token
export function setToken(token) {
    // token 代表要存储到本得的值
	return sessionStorage.setItem("储存到本地的名字", token)
}
//获取token
export function getToken() {
	return sessionStorage.getItem("储存到本地的名字")
}
//清除token
export function removeToken() {
	return sessionStorage.removeItem("要清除的名字")
}