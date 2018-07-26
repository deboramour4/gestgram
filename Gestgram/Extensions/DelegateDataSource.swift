//
//  DelegateDataSource.swift
//  Gestgram
//
// Débora Moura and Mateus Sales
//  Created by Ada 2018 on 7/26/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

//Implements the delegate and dataSource of collectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //The first cell of the collectionView is custom (profileCell)
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCell
            cell.profileImage.image = images[1]
            cell.profileName.text = "Débora Secco"
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width/2
            return cell
        }
        
        //The others are custom and just have one image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CustomCell
        cell.imageCell.image = images[indexPath.row]
        
        return cell
    }
    
    //Calls the prepareForSegue with PhotoViewController and sets the selectedImageIndex
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    //Can move all the cells except the first one (profileCell)
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item != 0
    }
    
    //When the user tries to move to the profileCell the cell goes to the first row/section
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.row == 0 {
            return IndexPath(row: proposedIndexPath.row + 1 , section: proposedIndexPath.section)
        } else {
            return proposedIndexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if (destinationIndexPath.item != 0) {
            //Trying to animate back
            UIView.animate(withDuration: 0.3, animations: {
                if let cell = self.collectionView.cellForItem(at: destinationIndexPath) as? CustomCell {
                    cell.imageCell?.transform = CGAffineTransform.identity
                }
            })
            
            //Replaces the photo in the images Array
            let photo = images.remove(at: sourceIndexPath.item)
            images.insert(photo, at: destinationIndexPath.item)
        }
    }
}
