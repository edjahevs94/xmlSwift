//
//  ViewController.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 29/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capitalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callService()
  
    }
    
    func callService() {
        Service.shared.getStringData(capitalCode: "US") { (response) in
            switch response.result {
            case .success(let data):
                print(data.body?.capitalResponse?.name ?? "nil")
                self.capitalLabel.text = data.body?.capitalResponse?.name
            case .failure(let error):
                print(error)
                
            }
            
            
        }
    }

}

