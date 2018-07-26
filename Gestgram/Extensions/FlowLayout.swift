//
//  FlowLayout.swift
//  Gestgram
//
// Débora Moura and Mateus Sales
//  Created by Ada 2018 on 7/26/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

extension ViewController : UICollectionViewDelegateFlowLayout {
    //Set the inset value to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    //Set the space between lines to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (section == 0) {
            return 0.0
        }
        
        return minimunLineSpacing
    }
    
    //Set the space between columns to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimunInteritemSpacing
    }
    
    //Calculates the width and height of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath.row == 0) {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height/2.8)
        }
        
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimunInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((view.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow).rounded(.down))
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

