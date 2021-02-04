//
//  UdacityAPIClient.swift
//  On the map
//
//  Created by Jessie Hon on 2021-02-03.
//

import Foundation

class UdacityAPIClient {
  
  struct Auth {
    //static var username = ""
    static var user_id = ""
    static var sessionId = ""
  }
  
  enum Endpoints {
    static let base = "https://onthemap-api.udacity.com/v1"
    
    case login
    case session
    case userData
    
    var stringValue: String {
      switch self {
      case .login: return Endpoints.base + "/session"
      case .session: return Endpoints.base + "/session"
      case .userData: return Endpoints.base + "/users/\(Auth.user_id)"
      }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
  }

  class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try! JSONEncoder().encode(body)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    print("before actual task")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      print("inside task")
      guard let data = data else {
        DispatchQueue.main.async {
          completion(nil, error)
        }
        return
      }
      let decoder = JSONDecoder()
      let range = (5..<data.count)
      let newData = data.subdata(in: range)
      do {
        print("before decoding")
        let responseObject = try decoder.decode(SessionResponse.self, from: newData)
        DispatchQueue.main.async {
          completion(responseObject as! ResponseType, nil)
        }
      } catch {
        
        do {
          let errorResponse = try decoder.decode(LoginErrorResponse.self, from: data)
          DispatchQueue.main.async {
            completion(nil, errorResponse)
          }
        } catch {
          DispatchQueue.main.async {
            completion(nil, error)
 
        print("error in decoding")
        print(error.localizedDescription)
        }
      }
      }
    }
    task.resume()
  }
  
  
  class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
    let body = LoginRequest(udacity: Udacity(username: username, password: password))
    
    print("before task")
    taskForPOSTRequest(url: Endpoints.login.url, responseType: SessionResponse.self, body: body) { response, error in
      if let response = response {
        print("got response")
        Auth.sessionId = response.session.id
        completion(true, nil)
      } else {
        completion(false, error)
      }
      
    }
  }
  
}
