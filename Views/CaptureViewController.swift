
import UIKit
import CoreLocation

protocol CaptureViewControllerDelegate {
    func canShowAlert()
}

class CaptureViewController: UIViewController {
    
    var delegate: CaptureViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParentViewController() {
            print("view will disappear")
            delegate?.canShowAlert()
        }
        

    }
    
}

extension CaptureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { _ in
            
        }
    }
}