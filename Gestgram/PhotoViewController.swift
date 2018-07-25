//
//  PhotoViewController.swift
//  Gestgram
//
//  Created by Ada 2018 on 7/24/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    
    var myImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImage.image = myImage
        
        //Pinch Gesture
        photoImage.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        photoImage.addGestureRecognizer(pinchGesture)
        
        //Rotate Gesture
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.rotationGesture))
        photoImage.addGestureRecognizer(rotationGesture)
        
        //Setando Deleagte
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        
        //Swipe Gesture Left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe: )))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        //Swipe Gesture Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        if sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                 sender.view?.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func rotationGesture(sender: UIRotationGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
}

extension PhotoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension PhotoViewController {
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction{
        case UISwipeGestureRecognizerDirection.left:
            heartImage.image = #imageLiteral(resourceName: "heart_outline")
            break
        case UISwipeGestureRecognizerDirection.right: //left
            heartImage.image = #imageLiteral(resourceName: "heart")

            break
        default:
            break
        }
    }
}
