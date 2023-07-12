class RequestUtil {
    constructor() {}

    static httpGetAsync(url, headers, responseType) {
        const promise = new Promise((resolve, reject) => {
            const request = new XMLHttpRequest();
            request.open('GET', url, true);
            for (const header of headers) {
                request.setRequestHeader(header[0], header[1]);
            }

            if (responseType !== undefined) {
                request.responseType = responseType;
            }

            request.onerror = () => {
                reject('error');
            };
            request.ontimeout = () => {
                reject('timeout');
            };
            request.onabort = () => {
                reject('abort');
            };
            request.onload = () => {
                if (request.status !== 200) {
                    reject(request.statusText);
                    return;
                }

                resolve(request.response);
            };
            request.send();
        });

        return promise;
    }
}

export default RequestUtil;
