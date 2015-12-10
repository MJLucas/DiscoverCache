
import UIKit
import CoreLocation

protocol CaptureViewControllerDelegate {
    func canShowAlert()
}

class CaptureViewController: UIViewController {
    
    var image: UIImage?
    var delegate: CaptureViewControllerDelegate?
    
    
    @IBOutlet weak var myImage: UIImageView!
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
    
    func unlockGeocache() {
        
    }
    
}

extension CaptureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        self.image = image
        myImage.image = image
        unlockGeocache()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { _ in
        }
    }
}