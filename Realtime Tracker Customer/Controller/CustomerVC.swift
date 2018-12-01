//
//  CustomerVC.swift
//  Realtime Tracker Customer
//
//  Created by bookr on 9/23/18.
//  Copyright © 2018 bookr. All rights reserved.
//

import UIKit
import MapKit

class CustomerVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
}
    
    
    @IBAction func track(_ sender: Any) {
    }
    

    @IBAction func logout(_ sender: Any) {
if Authprovider.Instance.logOut() {
            dismiss(animated: true, completion: nil);
        } else {
    
    alertTheUser(title: "Could not logout", message: "Please try again later");
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        _ = UIAlertAction(title: "OK", style: .default
            , handler: nil);
        present(alert, animated: true, completion: nil)
    
    }
    

}
// class










