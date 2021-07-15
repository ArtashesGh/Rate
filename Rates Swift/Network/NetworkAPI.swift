//
//  NetworkAPI.swift
//  Rate Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import Foundation
import RxSwift

struct RateCommand: Codable {
    var method:String
    var uid: String
    var type: String
    var rid: String
    var parameterR:String
    var parameterD:String
    var parameterT:String
    var parameterV:String
    
}


struct NetworkAPI {
    static let shared: NetworkAPI = .init(baseUrl: Constants.NetworkingPaths.baseURL!)
    
    var baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    static func getPostString(params: [String: Any]) -> String {
        var data = [String]()
        for (key, value) in params {
            if let valueData = value as? Data {
                data.append(key + "=\(String(describing: String(data: valueData, encoding: .utf8)))")
            }
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    private func getPostString(params: [String: Any]) -> String {
        var data = [String]()
        for (key, value) in params {
            if let valueData = value as? Data {
                data.append(key + "=\(String(describing: String(data: valueData, encoding: .utf8)))")
            } else {
                data.append(key + "=\(value)")
            }
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func command(data: RateCommand) -> Observable<RatesListResponse> {
        return Observable<RatesListResponse>.create { obs in
            var components = URLComponents(url: self.baseUrl.appendingPathComponent(data.method), resolvingAgainstBaseURL: false)!
            components.queryItems = [
                URLQueryItem(name: "v", value: "\(data.parameterV)"),
                URLQueryItem(name: "r", value: "\(data.parameterR)"),
                URLQueryItem(name: "d", value: "\(data.parameterD)"),
                URLQueryItem(name: "t", value: "\(data.parameterT)")
            ]
            
            var request = URLRequest(url: components.url!)
            
            request.httpMethod = "POST"
            
            let postString = self.getPostString(params: ["uid":data.uid,
                                                         "type": data.type,
                                                         "rid": data.rid])
            
            
           
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)", forHTTPHeaderField: "User-Agent")
            request.httpBody = postString.data(using: .utf8)
            
            let tsk = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    obs.onError(error!)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   let userError = self.handleHTTPResponse(httpResponse, data: data) {
                    obs.onError(userError)
                    return
                }
                
                guard data != nil else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response"])
                    obs.onError(error)
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(RatesListResponse.self, from: data!)
                    
                    if (res.rates?.count ?? 0) <= 0 {
                        obs.onError(NSError(domain: "com.less.platform.Rate-Swift", code: 0, userInfo: [NSLocalizedDescriptionKey: "error status"]))
                        
                        return
                    }
                    
                    
                    obs.onNext(res)
                    obs.onCompleted()
                    
                } catch let err {
                    obs.onError(err)
                }
            })
            tsk.resume()
            return Disposables.create { tsk.cancel() }
        }
    }
}

extension NetworkAPI {
    enum HTTPCodes: Int {
        case success = 200,
             userMessage = 400,
             tokenExpired = 401,
             accessDenied = 403,
             serverError = 500,
             unknown = -1
    }
    
    struct UserError: Error, Codable {
        static let unknown: UserError = .init(status: -1, http_status: -1, error: "")
        
        let status: Int
        let http_status: Int
        let error: String
        
        var localizedDescription: String { error }
    }
    
    /// True if success.
    func handleHTTPResponse(_ response: HTTPURLResponse, data: Data?) -> UserError? {
        
        let httpCode: HTTPCodes = HTTPCodes(rawValue: response.statusCode) ?? .unknown
        let userError: UserError = {
            guard let data = data else { return .unknown }
            do {
                let userError = try JSONDecoder().decode(UserError.self, from: data)
                return userError
            } catch {
                let userError = UserError(status: 0, http_status: 0, error: String(data: data, encoding: .utf8) ?? "")
                return userError
            }
        }()
        
        switch httpCode {
        case .success:
            return nil
        case .userMessage:
            DispatchQueue.main.async {
                showUserMessage(title: userError.error)
            }
            return userError
        case .tokenExpired:
            return userError
        case .accessDenied:
            return userError
        case .serverError:
            return userError
        case .unknown:
            return userError
        }
    }
    
    func showUserMessage(title: String?, message: String? = nil, style: UIAlertController.Style = .alert) {
        guard let root = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController else { return }
        
        func topController(from controller: UIViewController) -> UIViewController? {
            if let navigation = controller as? UINavigationController,
               let top = navigation.visibleViewController {
                return topController(from: top)
            }
            
            if let presented = controller.presentedViewController {
                return topController(from: presented)
            }
            
            return controller
        }
        
        guard let controller: UIViewController = topController(from: root) else { return }
        
        let alert: UIAlertController = .init(title: title, message: message, preferredStyle: style)
        alert.addAction(.init(title: "OK", style: .cancel))
        controller.present(alert, animated: true)
    }
    
}


