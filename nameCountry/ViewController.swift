import UIKit
import CoreLocation
class ViewController: UIViewController,  CLLocationManagerDelegate{

    @IBOutlet weak var main_tvDate:UILabel!
    @IBOutlet weak var main_tvLat:UILabel!
    @IBOutlet weak var main_tvLon:UILabel!
    @IBOutlet weak var main_tvCountry:UILabel!
    @IBOutlet weak var main_buFind:UIButton!
    var lat = 0.0
    var lon = 0.0
    var lName = ""
    var locationManger = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    func getLocationInfo(Location:CLLocation){
        //Geocoding
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(Location) { placemarks, error in
            let place = placemarks?.first
            if let error = error{
                print(error.localizedDescription)
            }
            else if let placeMark = place?.locality{
                self.lName = placeMark.capitalized
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Latitude And Longitude
        let latitude = locations[0].coordinate.latitude
        let longitude = locations[0].coordinate.longitude
        lat = latitude
        lon = longitude
        //Get Location Info
        getLocationInfo(Location: CLLocation(latitude: latitude, longitude: longitude))
        locationManger.stopUpdatingHeading()
        
    }
    @IBAction func main_buFind(_ sender:Any){
        //Date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy"
        let dateCurrent = dateFormatter.string(from: date)
        self.main_tvDate.text = String(dateCurrent)
        //Latitude And Longitude
        self.main_tvLat.text = "Latitude: \(lat)"
        self.main_tvLon.text = "Longitude: \(lon)"
        self.main_tvCountry.text = "Country: \(lName)"
    }
}

