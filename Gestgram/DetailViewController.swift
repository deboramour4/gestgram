//
//  DetailViewController.swift
//  Gestgram
//
//  Created by Ada 2018 on 7/25/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageDetail: UIImageView!
    
    var imageD : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageDetail.image = imageD

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
