//
//  PhotoViewController.swift
//  Gestgram
//
//  Created by Ada 2018 on 7/24/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    //Outlets from view
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    
    //Image to photoImage imageView (Received from ViewController prepareforSegue)
    var myImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the photoImage image received from ViewController
        self.photoImage.image = myImage
        
        //Enabling user Interaction with the photoImage UIImageView
        photoImage.isUserInteractionEnabled = true
        
        //Creating target-action of pinch gesture and adding it to photoImage
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        photoImage.addGestureRecognizer(pinchGesture)
        
        //Creating target-action of rotation gesture and adding it to photoImage
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.rotationGesture))
        photoImage.addGestureRecognizer(rotationGesture)
        
        //Seting Delegate of gestures to enable simutaneous gestures in photoImage
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        
        //Creating target-action of doubleTap gesture and adding it to view
        let doubleTap = UITapGestureRecognizer(target: self, action:#selector(doubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Implements the pinchGesture target-action
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        if sender.state == .changed {
            //Scales the photoImage based on the pinch gesture scale
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            //Sensitivity of zooming
            sender.scale = 1.0
        } else if sender.state == .ended {
            //Trying to animate (and works) to return to original size
            UIView.animate(withDuration: 0.3, animations: {
                 sender.view?.transform = CGAffineTransform.identity
            })
        }
    }
    
    //Implements the rotationGesture target-action
    @objc func rotationGesture(sender: UIRotationGestureRecognizer) {
        //Rotates the photoImage based on the rotation gesture rotation
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        //Sensitivity of rotating
        sender.rotation = 0.0
    }
    
    //Implements the doubleTap target-action
    @objc func doubleTap(sender: UIPinchGestureRecognizer) {
        if heartImage.image == #imageLiteral(resourceName: "heart") {
            heartImage.image = #imageLiteral(resourceName: "heart_outline")
        } else {
            heartImage.image = #imageLiteral(resourceName: "heart")
        }
    }

}

extension PhotoViewController: UIGestureRecognizerDelegate {
    //Enable simutaneous gestures
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
