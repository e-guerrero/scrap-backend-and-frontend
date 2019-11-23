//
//  LoginController.swift
//  Scrap
//
//  Created by Edwin on 11/15/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit
import MapKit

class LoginController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var loginBtnText: String?
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var popUp: UIView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUp.layer.cornerRadius = 10
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        
        if(Store.storeInstance().register.email.isEmpty == false)
        {
            self.emailTxtField.text = Store.storeInstance().register.email
        }
        if(Store.storeInstance().register.password.isEmpty == false)
        {
            self.passwordTxtField.text = Store.storeInstance().register.password
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request permission from user for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == emailTxtField)
        {
            moveTextField(textField, moveDistance: -130, up: true)
        }
        else if(textField == passwordTxtField)
        {
            moveTextField(textField, moveDistance: -200, up: true)
        }
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == emailTxtField)
        {
            moveTextField(textField, moveDistance: -130, up: false)
        }
        else if(textField == passwordTxtField)
        {
            moveTextField(textField, moveDistance: -200, up: false)
        }
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //textField.endEditing(true)
        //self.view.endEditing(true)
        return true
    }
    
    // Move the text field with animation
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        emailTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        
        showLoading()
        
        let login : DTO_Login = Store.storeInstance().login
        login.email = self.emailTxtField.text!
        login.password = self.passwordTxtField.text!
        login.longitude = self.locationManager.location!.coordinate.longitude
        login.latitude = self.locationManager.location!.coordinate.latitude
        
        // Temporary fix till web services fixes LoginUser web method to return back coordinates
        let longTemp = login.longitude
        let latTemp = login.latitude
        
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
                
                if (dm.loginNotFound()){
                    print("Login: Not Found")
                    self.loginBtn.isEnabled = false
                    self.emailTxtField.isEnabled = false
                    self.passwordTxtField.isEnabled = false
                    self.view.addSubview(self.popUp)
                    self.popUp.center = self.view.center
                }
                else{
                    print("Login: Load Finished")
                    // Temporary fix till LoginUser web method starts returning back coordinates
                    Store.storeInstance().login.longitude = longTemp
                    Store.storeInstance().login.latitude = latTemp
                    self.performSegue(withIdentifier: "loginSegue", sender: "nil")
                }
            }
        }
    }
    
    func showLoading() {
        loginBtnText = loginBtn.titleLabel?.text
        loginBtn.setTitle("", for: .normal)
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
        loginBtn.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: loginBtn, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        loginBtn.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: loginBtn, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        loginBtn.addConstraint(yCenterConstraint)
    }
    
    func hideLoading() {
        loginBtn.setTitle(loginBtnText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    @IBAction func tryAgainBtn(_ sender: UIButton) {
        self.popUp.removeFromSuperview()
        self.loginBtn.isEnabled = true
        self.emailTxtField.isEnabled = true
        self.passwordTxtField.isEnabled = true
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registerSegue", sender: "nil")
    }
    
    
    
} // end of LoginController

