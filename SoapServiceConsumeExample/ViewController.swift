//
//  ViewController.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 29/09/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callService()
  
    }
    
    func callService() {
        Service.getStringData { response in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
  

}

