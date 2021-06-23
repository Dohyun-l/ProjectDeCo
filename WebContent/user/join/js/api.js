export const getPostRequest = (reqData) => {
    let data = {
        reqData:reqData
	}
	
	let fetchData = {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json'
        }
    }
    return fetchData;
}

export const kakaoRequest = (params) => {
	
    let fetchData = {
        method: 'POST',
        body: JSON.stringify(params),
    }
    return fetchData;
}