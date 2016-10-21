//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Haider Abbas on 20/10/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var lblLocation: UILabel!
    
    // MARK: - Properties
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private var arrWeathers: [[String: AnyObject]]!
    
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyCYdqBv8I0EXSDAraCCDWqHLGT0rlPoFIQ",
        placeType: .Address
    )
    
    // MARK: - Initializers methods
    
    func setInitialParams(){
        self.navigationItem.title = "Weather"
        
        gpaViewController.placeDelegate = self
        gpaViewController.navigationBar.barStyle = UIBarStyle.Black
        gpaViewController.navigationBar.translucent = false
        gpaViewController.navigationBar.barTintColor = Colors.navigationBarColor
        gpaViewController.navigationBar.tintColor = UIColor.whiteColor()
        gpaViewController.navigationBar.titleTextAttributes = [NSFontAttributeName: SearchControllerFont!]
        
        arrWeathers = []
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialParams()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // MARK: - Lifetime
    
    // MARK: - Private methods
    
    // MARK: - Public methods
    
    // MARK: - Public methods
    
    // MARK: - Getter & setter methods
    
    // MARK: - IBActions
    @IBAction func changeLocation(sender: AnyObject) {
        if appDelegate.isInternetActive == true {
            presentViewController(gpaViewController, animated: true, completion: nil)
        } else {
            appDelegate.displayAlertWithTitle("Oops!", message: "Please check your Internet Connectivity")
        }
        
    }
    
    // MARK: - Target-Action methods
    
    // MARK: - Notification handler methods
    
    // MARK: - Datasource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeathers.count
        //return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weather = arrWeathers[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherForecastTableViewCell") as! WeatherTableViewCell
        //cell.configure()
        cell.config(withWeathers: weather)
        return cell
    }
    
    
    // MARK: - Delegate methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }


}

//MARK: ViewController Extension

extension ViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        print(place.description)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        place.getDetails { details in
            print(details)
            self.lblLocation.text = place.description
            // A querystring param.
            CPProgressView.shared.showProgressView()
            WEATHERAPI.FORECAST.get(["lat": "\(details.latitude)", "lon":"\(details.longitude)", "APPID": WEATHERAPIKEY]) { response in
                
                CPProgressView.shared.hideProgressView()
                
                guard response.error == nil else {
                    return self.appDelegate.displayAlertWithTitle("Error \((response.error?.code)!)", message: (response.error?.localizedDescription)!)
                }
                
                guard let jsonDict = response.responseJSON as? JSONDictionary else {
                    return self.appDelegate.displayAlertWithTitle("Error", message: "Error: couldn't parse JSON from data")
                }
                
                //print("\(jsonDict)")
            
                guard let weatherList = jsonDict["list"] as? [[String: AnyObject]] where (weatherList.count > 0)  else {
                    return self.appDelegate.displayAlertWithTitle("Oops", message: "No weather data found of your location")
                }
                
                print("\(weatherList.count)")
                
                if weatherList.count > 0 {
                    self.arrWeathers = weatherList
                } else {
                    self.arrWeathers = [[String: AnyObject]]()
                }
                
                self.weatherTable.reloadData()
                
                
            }
        }
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

