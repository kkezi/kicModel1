/**
파일마다 method(get,post)처리하는 역할
 * 
 */
function ajax(url, params, callback, method) {
	const xhttp = new XMLHttpRequest()
	
	method = method.toUpperCase() //method방식 get과 post를 대문자로 넣기
	if(method != 'POST') {method ='GET'} //post가 아니면 get밖에 없음 
	if(method =='GET') {url =url +"?"+params}
	
	xhttp.open(method, url, true) //true는 비동기를 의미
	xhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded'); //post일때는 이게 없으면 안됨 
	xhttp.send(method =='POST'? params : null)
	xhttp.onreadystatechange =callback
	
}