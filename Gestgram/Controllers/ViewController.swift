//
//  ViewController.swift
//  Gestgram
//
// Débora Moura and Mateus Sales
//  Created by Ada 2018 on 7/24/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Outlets from View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Values for UICollectionViewFlowLayout
    let inset: CGFloat = 3
    var minimunLineSpacing: CGFloat = 3
    let minimunInteritemSpacing: CGFloat = 3
    var cellsPerRow = 3
    var addCellFrame: CGRect!
    
    //Variable to save the indexPath.row of selected image with tap
    var selectedImageIndex = 0
    
    //Variable to save the indexPath.row of selected image with 3d Touch
    var selectedImageIndexForceTouch = 0
    
    //Array of images
    var images = [
        UIImage(named: "img1.jpg")!,
        UIImage(named: "img2.jpg")!,
        UIImage(named: "img3.jpg")!,
        UIImage(named: "img4.jpg")!,
        UIImage(named: "img5.jpg")!,
        UIImage(named: "img1.jpg")!,
        UIImage(named: "img2.jpg")!,
        UIImage(named: "img3.jpg")!,
        UIImage(named: "img4.jpg")!,
        UIImage(named: "img5.jpg")!,
        UIImage(named: "img6.jpg")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set delegate and dataSource of collectionView
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.dataSource = self as UICollectionViewDataSource
        
        //Creating target-action of longPress gesture and adding it to collectionView
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(sender:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
        //Creating target-action of swipe left gesture, seting its direction and adding it to view
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe: )))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        //Creating target-action of swipe right gesture, seting its direction and adding it to view
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
        //Check if the device suports 3D Touch
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView)
        }
        else {
            print("Não suporta!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func listAction(_ sender: Any) {
        changeToList()
    }
    
    @IBAction func gridAction(_ sender: Any) {
        changeToGrid()
    }
    
    //Change the layout to list
    func changeToList() {
        cellsPerRow = 1
        minimunLineSpacing = 20
        collectionView.collectionViewLayout.invalidateLayout()
        
        //Change the color of icons  item toolbar
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileCell
        cell.gridItem.tintColor = UIColor.black.withAlphaComponent(0.5)
        cell.listItem.tintColor = UIColor.black
    }
    
    //Change the layout to grid
    func changeToGrid() {
        cellsPerRow = 3
        minimunLineSpacing = 3
        collectionView.collectionViewLayout.invalidateLayout()
        
        //Change the color of icons item toolbar
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileCell
        cell.listItem.tintColor = UIColor.black.withAlphaComponent(0.5)
        cell.gridItem.tintColor = UIColor.black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Sending the selected image to PhotoViewController
        if segue.destination is PhotoViewController {
            let vc = segue.destination as! PhotoViewController
            vc.myImage = self.images[selectedImageIndex]
        }
        
        //Sending the selected image (with 3d Touch) to DetailViewController
        if segue.identifier == "showDetail" {
            let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            detailViewController.imageDetail.image = images[selectedImageIndexForceTouch]
        }
    }
    
    //Implements the longPress target-action
    @objc func longPressGesture(sender : UILongPressGestureRecognizer!) {
        //Finds the indexPath of the cell based on the location of the longPressGesture
        guard let selectedIndexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) else {
            return
        }
        
        switch(sender.state) {
        case .began:
            //Starts interactive movement
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
            //Trying to animate
            UIView.animate(withDuration: 0.3, animations: {
                if let cell = self.collectionView.cellForItem(at: selectedIndexPath) as? CustomCell {
                    cell.imageCell?.transform = (cell.contentView.transform.scaledBy(x: 0.9, y: 0.9))
                }
            })
        case .changed:
            //Updates the position of the cell based on the location of the longPressGesture
            collectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            //Called wWhen the longPressGesture ends
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    //Implements the swipeGesture target-action
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction{
        case UISwipeGestureRecognizerDirection.left:
            changeToList()
            break
        case UISwipeGestureRecognizerDirection.right:
            changeToGrid()
            break
        default:
            break
        }
    }
    
}
