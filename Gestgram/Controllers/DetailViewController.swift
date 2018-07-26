//
//  DetailViewController.swift
//  Gestgram
//
// Débora Moura and Mateus Sales
//  Created by Ada 2018 on 7/25/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageDetail: UIImageView!
    
    var imageD : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the image of imageDetail imageView
        imageDetail.image = imageD
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
