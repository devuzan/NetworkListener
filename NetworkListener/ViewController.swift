//
//  ViewController.swift
//  Listener
//
//  Created by Yusuf U on 07/09/2017.
//  Copyright © 2017 Mobixoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.sharedInstance.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NetworkManager.sharedInstance.removeListener(listener: self)
    }
}


extension ViewController: NetworkManagerListener{

    func networkStatusChanged(status: Reachability.NetworkStatus) {
        
        DispatchQueue.main.async {
            self.label.text = status.description
        }
    }

}

