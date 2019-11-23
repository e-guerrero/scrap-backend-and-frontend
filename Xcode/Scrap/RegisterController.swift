//
//  RegisterController.swift
//  Scrap
//
//  Created by Edwin on 12/4/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit
import MapKit

class RegisterController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    var registerBtnText: String?
    var activityIndicator: UIActivityIndicatorView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        password.delegate = self
        phone.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Doesn't need this request again...
//        // Request permission from user for Location Services
//        if (CLLocationManager.locationServicesEnabled()) {
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//        }
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // Click anywhere to hide keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        if(textField == email)
        {
            //moveTextField(textField, moveDistance: -0, up: true)
        }
        else if(textField == firstName)
        {
            //moveTextField(textField, moveDistance: -0, up: true)
        }
        else if(textField == lastName)
        {
            //moveTextField(textField, moveDistance: -0, up: true)
        }
        else if(textField == password)
        {
            //moveTextField(textField, moveDistance: -0, up: true)
        }
        else if(textField == phone)
        {
            //moveTextField(textField, moveDistance: -0, up: true)
        }
    }
//
//    // Finish Editing The Text Field
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if(textField == email)
//        {
//            //moveTextField(textField, moveDistance: -0, up: false)
//        }
//        else if(textField == firstName)
//        {
//            //moveTextField(textField, moveDistance: -0, up: false)
//        }
//        else if(textField == lastName)
//        {
//            //moveTextField(textField, moveDistance: -0, up: false)
//        }
//        else if(textField == password)
//        {
//            //moveTextField(textField, moveDistance: -0, up: false)
//        }
//        else if(textField == phone)
//        {
//            //moveTextField(textField, moveDistance: -0, up: false)
//        }
//    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //textField.endEditing(true)
        //self.view.endEditing(true)
        return true
    }
    
//    // Move the text field with animation
//    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
//        let moveDuration = 0.3
//        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
//
//        UIView.beginAnimations("animateTextField", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(moveDuration)
//        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
//        UIView.commitAnimations()
//    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        email.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        password.resignFirstResponder()
        phone.resignFirstResponder()
        
        if((email.text?.isEmpty)! || (firstName.text?.isEmpty)! || (lastName.text?.isEmpty)! || (password.text?.isEmpty)! || (phone.text?.isEmpty)!)
        {
            if((email.text?.isEmpty)!)
            {
                email.text = "Enter email!"
                email.textColor = UIColor.red
            }
            if((firstName.text?.isEmpty)!)
            {
                firstName.text = "Enter first name!"
                firstName.textColor = UIColor.red
            }
            if((lastName.text?.isEmpty)!)
            {
                lastName.text = "Enter last name!"
                lastName.textColor = UIColor.red
            }
            if((password.text?.isEmpty)!)
            {
                password.text = "Enter password!"
                password.textColor = UIColor.red
            }
            if((phone.text?.isEmpty)!)
            {
                phone.text = "Enter phone #!"
                phone.textColor = UIColor.red
            }
            return
        }
        
        showLoading()
        
        let register : DTO_Register = Store.storeInstance().register
        register.email = self.email.text!
        register.fName = self.firstName.text!
        register.lName = self.lastName.text!
        register.latitude = self.locationManager.location!.coordinate.latitude
        register.longitude = self.locationManager.location!.coordinate.longitude
        register.password = self.password.text!
        register.phone = self.phone.text!

        print("")
        print("Sending...")
        print("Email: \(register.email)")
        print("FirstName: \(register.fName)")
        print("LastName: \(register.lName)")
        print("Latitude: \(register.latitude)")
        print("Longitude: \(register.longitude)")
        print("Password: \(register.password)")
        print("Phone: \(register.phone)")
        print("")
        
        // Login with it to check if it already exists.
        let login : DTO_Login = Store.storeInstance().login
        login.email = register.email
        login.password = register.password
        login.longitude = register.longitude
        login.latitude = register.latitude
        
        print("")
        print("Sending...")
        print("Email: \(login.email)")
        print("Password: \(login.password)")
        print("Latitude: \(login.latitude)")
        print("Longitude: \(login.longitude)")
        print("")
        
        let dm = DataManager()
        dm.loadLogin
        {
            () in
            OperationQueue.main.addOperation
            {
                self.hideLoading()
                    
                if (dm.loginNotFound())
                {
                    print("Login: Not Found")
                    // Register if it doesn't exist.
                    dm.loadRegister
                    {
                        () in
                        OperationQueue.main.addOperation
                        {
                            self.hideLoading()
                            print("Register: Load Finished")
                            self.performSegue(withIdentifier: "backToLoginSegue", sender: "nil")
                        }
                    }
                }
                else{
                    print("Login: User already exists")
                    self.email.textColor = UIColor.red
                    self.email.text = "Email already exists!"
                }
            }
        }
    }
    
    func showLoading() {
        registerBtnText = registerBtn.titleLabel?.text
        registerBtn.setTitle("", for: .normal)
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        showSpinner()
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }
    
    func showSpinner() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: registerBtn, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        registerBtn.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: registerBtn, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        registerBtn.addConstraint(yCenterConstraint)
    }
    
    func hideLoading() {
        registerBtn.setTitle(registerBtnText, for: .normal)
        activityIndicator.stopAnimating()
    }
}


































