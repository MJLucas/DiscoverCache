
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    var alertShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        
        let bournemouthPier = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        let bournemouthPierRegion = CLCircularRegion(center: bournemouthPier, radius: 50, identifier: "Open your camera and take a picture")
        locationManager.startMonitoringForRegion(bournemouthPierRegion)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Capture" {
            let vc = segue.destinationViewController as! CaptureViewController
            vc.delegate = self
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //print("Entering \(region.identifier)")
        
        if !alertShowing {
            alertShowing = true
            let alert = UIAlertController(title: "You have found the Bournemouth Pier Geocache!", message: region.identifier, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Capture Geocache", style: .Default, handler: { _ in
                self.performSegueWithIdentifier("Capture", sender: self)
            }))
            alert.addAction(UIAlertAction(title: "Ignore Geocache", style: .Destructive, handler: { _ in
                self.alertShowing = false
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //print("Exiting Region \(region.identifier)")
    }
    
}

extension MapViewController: CaptureViewControllerDelegate {
    func canShowAlert() {
        alertShowing = false
    }
}
