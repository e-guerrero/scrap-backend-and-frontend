//
//  AccountController.swift
//  Scrap
//
//  Created by Edwin on 12/4/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit

class AccountController: UIViewController {

    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginData = Store.storeInstance().login
        fName.text = "First Name: \(loginData.fName)"
        lName.text = "Last Name: \(loginData.lName)"
        longitude.text = "Longitude: \(loginData.longitude)"
        latitude.text = "Latitude: \(loginData.latitude)"
        email.text = "Email: \(loginData.email)"
        phone.text = "Phone: \(loginData.phone)"
        id.text = "ID: \(loginData.id)"
    }
}
