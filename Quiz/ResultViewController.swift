//
//  ResultViewController.swift
//  Quiz
//
//  Created by MacStudent on 2019-11-14.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var result = 0
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var resText: UILabel!
    
    @IBAction func retryPress(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyQuizzViewController") as? MyQuizzViewController {
            
            if let navi = navigationController {
                navi.pushViewController(vc, animated: true)
            }
        }
        
    }
    @IBOutlet weak var performText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        resText.text = String(result) + "/5"
        
        if(result < 3){
            
            performText.text = "Please try again!"
        }else{
            
        }
        if(result == 3){
            
            performText.text = "Good job!"
        }
        if(result == 4){
            performText.text = "Excellent work!"
        }
        if(result == 5){
            performText.text = "You are a genius!"
        }
        
    }
    
    
    
}
