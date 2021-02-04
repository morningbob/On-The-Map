//
//  TabBarViewController.swift
//  On the map
//
//  Created by Jessie Hon on 2021-02-02.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  var data : Data?

    override func viewDidLoad() {
        super.viewDidLoad()
      print(String(data: data!, encoding: .utf8)!)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
