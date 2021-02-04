//
//  ViewController.swift
//  On the map
//
//  Created by Jessie Hon on 2021-02-02.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  var responseData : Data?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    username.text = ""
    password.text = ""
  }

  @IBAction func actionLogin(_ sender: Any) {
    print(username.text!)
    print(password.text!)
    //loginRequest()
    handleLoginResponse()
    
  }
  /*
  func loginRequest()  {
    var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    // encoding a JSON body from a string, can also use a Codable struct
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil { // Handle error…
          return
      }
      let range = 5..<data!.count //Range(5..<data!.count)
      self.responseData = data?.subdata(in: range) /* subset response data! */
      
      print(String(data: self.responseData!, encoding: .utf8)!)
      // login successful, proceed to TabBarController
      // pass info
      DispatchQueue.main.async {
        self.performSegue(withIdentifier: "toMainMenu", sender: nil)
      }
    }
    task.resume()
    
  }
 */
  
  func handleLoginResponse() {
    UdacityAPIClient.login(username: username.text!, password: password.text!, completion: handleSessionResponse(success:error:))
      
  }
  
  func handleSessionResponse(success: Bool, error: Error?) {
    if success {
      performSegue(withIdentifier: "toMainMenu", sender: nil)
    } else {
      // show login failure
      print(error?.localizedDescription ?? "")
    }
  }
  /*
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller = segue.destination as! TabBarViewController
    controller.data = self.responseData
  }
 */
}

