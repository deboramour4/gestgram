//
//  PreviewPeekandPop.swift
//  Gestgram
//
// Débora Moura and Mateus Sales
//  Created by Ada 2018 on 7/26/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

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
        
        //Set the height of the preview
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: 480.0)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        previewingContext.sourceRect = cell.frame
        
        return detailViewController
    }
    
    /// Present the view controller for the "Pop" action.
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        //Instantiates the variable of the viewController that will be shown in the "Pop" action
        guard let photoViewController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        
        //Sending the selected image (with 3d Touch) to PhotoViewController
        photoViewController.myImage = self.images[selectedImageIndexForceTouch]
        
        // Reuse the "Peek" view controller for presentation.
        show(photoViewController, sender: self)
    }
}
