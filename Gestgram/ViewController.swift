//
//  ViewController.swift
//  Gestgram
//
//  Created by Ada 2018 on 7/24/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Outlets from View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Values for UICollectionViewFlowLayout
    let inset: CGFloat = 3
    let minimunLineSpacing: CGFloat = 3
    let minimunInteritemSpacing: CGFloat = 3
    var cellsPerRow = 3
    var addCellFrame: CGRect!
    
    //Variables
    var selectedImageIndex = 0
    var selectedImageIndexForceTouch = 0
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(sender:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView)
        }
        else {
            // Create an alert to display to the user.
            print("Não suporta!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PhotoViewController {
            let vc = segue.destination as! PhotoViewController
            vc.myImage = self.images[selectedImageIndex]
        }
        
        if segue.identifier == "showDetail" {
            
            let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            
            // Pass the `title` to the `detailViewController`.
            detailViewController.imageDetail.image = images[selectedImageIndexForceTouch]
        }
    }
    
    @objc func longPressGesture(sender : UILongPressGestureRecognizer!) {
        switch(sender.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) else {
                break
            }
                UIView.animate(withDuration: 0.3, animations: {
                    if let cell = self.collectionView.cellForItem(at: selectedIndexPath) as? CustomCell {
                        cell.imageCell?.transform = (cell.contentView.transform.scaledBy(x: 0.9, y: 0.9))
                    }
                })
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) else {
                collectionView.endInteractiveMovement()
                break
            }
            collectionView.endInteractiveMovement()
//            UIView.animate(withDuration: 0.3, animations: {
//                if let cell = self.collectionView.cellForItem(at: selectedIndexPath) as? CustomCell {
//                    cell.imageCell?.transform = CGAffineTransform.identity
//                }
//            })
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCell
            
            cell.profileImage.image = images[1]
            cell.profileName.text = "Fulana de Tal"
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width/2
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CustomCell
        cell.imageCell.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item != 0
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.row == 0 {
            return IndexPath(row: proposedIndexPath.row + 1 , section: proposedIndexPath.section)
        } else {
            return proposedIndexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if (destinationIndexPath.item != 0) {
            let photo = images.remove(at: sourceIndexPath.item)
            images.insert(photo, at: destinationIndexPath.item)
        } else {
            
        }
    }
}


extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimunLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimunInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimunInteritemSpacing * CGFloat(cellsPerRow - 1)
        
        if (indexPath.row == 0) {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2.8)
        }
        
        let itemWidth = ((view.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow).rounded(.down))
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ViewController: UIViewControllerPreviewingDelegate {
    /// Create a previewing view controller to be shown at "Peek".
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Obtain the index path and the cell that was pressed.
        guard let indexPath = collectionView.indexPathForItem(at: location),
            let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        
        selectedImageIndexForceTouch = indexPath.row
        
        // Create a detail view controller and set its properties.
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return nil }
        
        detailViewController.imageD = images[selectedImageIndexForceTouch]
        
        /*
         Set the height of the preview by setting the preferred content size of the detail view controller.
         Width should be zero, because it's not used in portrait.
         */
        detailViewController.preferredContentSize = CGSize(width: 0.0, height:0.0)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        previewingContext.sourceRect = cell.frame
        
        return detailViewController
    }
    
    /// Present the view controller for the "Pop" action.
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        //show(viewControllerToCommit, sender: self)
    }
}
