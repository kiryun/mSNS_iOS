//
//  ApiClient.swift
//  mSNS_iOS
//
//  Created by Gihyun Kim on 2020/04/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation

extension URLSession {
    //error 항목 추가
    enum HTTPError: LocalizedError{
        case invalidResponse
        case invalidStatusCode
        case noData
    }
    
    func dataTask(with: URLRequest) -> Promise<Data> {
        return Promise<Data> { [unowned self] fulfill, reject in
            self.dataTask(with: with) { data, response, error in
                // 각 에러 case 마다 동작 정의(reject 메서드)
                if let error = error {
                    reject(error)
                    return
                }
//                print(response)
                guard let response = response as? HTTPURLResponse else {
                    print("invalidResponse")
                    reject(HTTPError.invalidResponse)
                    return
                }
//                print(response.statusCode)
//                print(response.statusCode >= 200 && response.statusCode < 300)
//                guard (response.statusCode >= 200 && response.statusCode < 300) else {
//                    print("invalidStatusCode")
//                    reject(HTTPError.invalidStatusCode)
//                    return
//                }
                guard let data = data else {
                    print("noData")
                    reject(HTTPError.noData)
                    return
                }
                // error 없이 무사히 통과한다면 fulfill 메서드 호출
                fulfill(data)
            }.resume()
        }
    }
}

class ApiClient {
    let session: URLSession = URLSession.shared
        
        //GET
        func get(url: URL) -> Promise<Data>{
            var request: URLRequest = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            
            //dataTask(with:completionHandler:): url 요청을 실시하고 완료시 핸들러를 호출하는 task를 작성한다.(여기서 completionHandler 는 closure 형태로 받아야함 콜백으로 실행될 것이기 때문)
            //resume(): 새로 초기화 된 작업은 일시 중단된 상태에서 시작되므로 작업을 시작하려면 이 메서드를 호출해야함
            return self.session.dataTask(with: request)
        }
        
        //POST
        func post(url: URL, body: NSMutableDictionary) -> Promise<Data> {
            print("APIClient.post")
            var request: URLRequest = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            catch{
                print("APIClient.post: \(error)")
            }
            
            return self.session.dataTask(with: request)
        }
}

// Promise 말고 vanilla 한 방법
extension ApiClient{
    // 나중에 이 밑에 메서드들 Generic 사용해서 Codable data 를 핸들링 할 수 있도록 하자.
    func _get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        self.session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    
    func _post(url: URL, body: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        print(url)
        print(body)
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        do{
            let json = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            request.httpBody = json
        }catch{
            print("APIClient._post: \(error)")
        }
        
        self.session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
