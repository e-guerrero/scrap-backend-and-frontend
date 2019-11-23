//
//  DataManager.swift
//  Scrap
//
//  Created by Edwin on 11/26/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import Foundation
import UIKit

private let _storeInstance = Store()

class Store : NSObject
{
    class func storeInstance() -> Store
    {
        return _storeInstance
    }
    var logins = [DTO_Login]()
    var login = DTO_Login()
    var offers = [DTO_Offer]()
    var offer = DTO_Offer()
    var image = DTO_Image() // url
    var registers = [DTO_Register]()
    var register = DTO_Register()
//    var transactions = [DTO_Transaction]()
//    var transaction = DTO_Transaction()
}

class DataManager
{
    func loadRegister(completionClosure:@escaping () ->())
    {
        let register = Store.storeInstance().register
        let jsonRequest =
            ["Email" : String(register.email),
             "FirstName" : String(register.fName),
             "LastName" : String(register.lName),
             "Latitude" : String(register.latitude),
             "Longitude" : String(register.longitude),
             "Password" : String(register.password),
             "Phone" : String(register.phone),
             "id" : String(0)]
        
        BLL.post(params: jsonRequest, remoteMethod: "RegisterUser")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    // Extraction also empties Store.storeInstance().login
                    // before refilling it back up.
                    BLL.Extract_DTO_Registers(responseData: data)
                    self.printRegister()
                    completionClosure()
            }
        }
    }
    
    func loadLogin(completionClosure:@escaping () ->())
    {
        let login = Store.storeInstance().login
        let jsonRequest =
            ["Email" : "\(login.email)",
             "Id" : String(0),
             "Latutude" : String(login.latitude),
             "Longitude" : String(login.longitude),
             "Password" : "\(login.password)"]
        
        BLL.post(params: jsonRequest, remoteMethod: "LoginUser")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
            {
                // Extraction also empties Store.storeInstance().login
                // before refilling it back up.
                BLL.Extract_DTO_Logins(responseData: data)
                self.printLogin()
                completionClosure()
            }
        }
    }
    
    func loadOffers(completionClosure:@escaping () ->())
    {
        BLL.post(params: [:], remoteMethod: "GetOffers")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
            {
                BLL.Extract_DTO_Offers(responseData: data)
                // self.printOffers()
                completionClosure()
            }
        }
    }
    
    func loadOffersPriceUp(completionClosure:@escaping () ->())
    {
        BLL.post(params: [:], remoteMethod: "GetOffersByPriceAscending")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func loadOffersPriceDown(completionClosure:@escaping () ->())
    {
        BLL.post(params: [:], remoteMethod: "GetOffersByPriceDescending")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func loadOffersNewest(completionClosure:@escaping () ->())
    {
        BLL.post(params: [:], remoteMethod: "GetNewestOffers")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func loadOffersOldest(completionClosure:@escaping () ->())
    {
        BLL.post(params: [:], remoteMethod: "GetOldestOffers")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func loadOffersClosest(completionClosure:@escaping () ->())
    {
        let login = Store.storeInstance().login
        let jsonRequest =
            ["Email" : "\(login.email)",
                "Id" : String(0),
                "Latutude" : String(login.latitude),
                "Longitude" : String(login.longitude),
                "Password" : "\(login.password)"]
        
        BLL.post(params: jsonRequest, remoteMethod: "GetClosestOffersToUser")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func loadOffersFurthest(completionClosure:@escaping () ->())
    {
        let login = Store.storeInstance().login
        let jsonRequest =
            ["Email" : "\(login.email)",
                "Id" : String(0),
                "Latutude" : String(login.latitude),
                "Longitude" : String(login.longitude),
                "Password" : "\(login.password)"]
        
        BLL.post(params: jsonRequest, remoteMethod: "GetFurthestOffersFromUser")
        {
            (data: NSData) in
            OperationQueue.main.addOperation
                {
                    BLL.Extract_DTO_Offers(responseData: data)
                    // self.printOffers()
                    completionClosure()
            }
        }
    }
    
    func uploadImage(studentID: Int, image: String, fileName: String , imageData: String, completionClosure: @escaping () ->())
    {
        let jsonrequest = [ "studentID" : String(studentID),
                            "FileName" : fileName,
                            "Image" : image,
                            "ImageData" : imageData]
        
        
        //print(jsonrequest)
        
        BLL.post(params: jsonrequest, remoteMethod: "uploadImage") {
            
            (data: NSData) in
            
            OperationQueue.main.addOperation {
                
                BLL.Extract_DTO_Image(responseData: data)
                completionClosure()
            }
        }
    }
    
    func loginNotFound() -> Bool
    {
        if(Store.storeInstance().logins.isEmpty){
            return true
        }
        return false
    }
    
    func printRegister()
    {
        print("")
        print("Register Recieved...")
        for r in Store.storeInstance().registers
        {
            print("Email: \(r.email)")
            print("FirstName: \(r.fName)")
            print("LastName: \(r.lName)")
            print("Latitude: \(r.latitude)")
            print("Longitude: \(r.longitude)")
            print("Password: \(r.password)")
            print("Phone: \(r.phone)")
            print("id: trash")
        }
        print("")
    }
    
    func printLogin()
    {
        print("")
        print("Login Recieved...")
        for l in Store.storeInstance().logins
        {
            print("Email: \(l.email)")
            print("ID: \(l.id)")
            print("Password: \(l.password)")
            // Web Call does not return coordinates at all!
            //print("Longitude: \(l.longitude)")
            //print("Latitude: \(l.latitude)")
            print("Phone: \(l.phone)")
        }
        print("")
    }
    
    func printOffers()
    {
        print("")
        print("Offers Recieved")
        for o in Store.storeInstance().offers
        {
            print("Date/Time: \(o.dateTime)")
            print("Offer ID: \(o.offerId)")
            print("Status: \(o.status)")
            print("Part ID: \(o.partId)")
            print("Price: \(o.price)")
            print("Quantity: \(o.qty)")
            print("Seller ID: \(o.sellerId)")
        }
        print("")
    }
} // end of DataManager

class BLL
{
    static let BaseURL : String = "http://www.jerrybhill.com/scrap/Service1.svc/"
    static let BaseImageURL : String = "http://www.jerrybhill.com/scrapImages/"
    static var ErrorMessage : String = ""
    
    static func post(params : Dictionary<String, String>, remoteMethod: String ,completionClosure: @escaping (_ data :NSData) ->())
    {
        let urlString: String = "\(BaseURL)\(remoteMethod)"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        catch
        {
            print("Error:\n \(error)")
            ErrorMessage = "\(error)"
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                print("General Network error=\(error!)")
                return
            }
            
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            completionClosure(data as NSData)
            
        }
        task.resume()
    }
    
    static func Extract_DTO_Registers(responseData: NSData)
    {
        if(responseData.length == 0)
        {
            return
        }
        
        Store.storeInstance().registers.removeAll()
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: responseData as Data, options: .allowFragments)
                as! [String:AnyObject]
            
            // print(json)
            
            if let items = json["Data"] as? [[String:AnyObject]]
            {
                for item in items
                {
                    let single = DTO_Register.Create(dict: item as NSDictionary)
                    Store.storeInstance().registers.append(single)
                    Store.storeInstance().register = single
                }
            }
        }
        catch let error
        {
            print("error parsing DTO_Register \(error)")
            return
        }
    }
    
    static func Extract_DTO_Logins(responseData: NSData)
    {
        if(responseData.length == 0)
        {
            return
        }
        
        Store.storeInstance().logins.removeAll()
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: responseData as Data, options: .allowFragments)
                as! [String:AnyObject]
            
            // print(json)
            
            if let items = json["Data"] as? [[String:AnyObject]]
            {
                for item in items
                {
                    let single = DTO_Login.Create(dict: item as NSDictionary)
                    Store.storeInstance().logins.append(single)
                    Store.storeInstance().login = single
                }
            }
        }
        catch let error
        {
            print("error parsing DTO_Login \(error)")
            return
        }
    }
    
    static func Extract_DTO_Offers(responseData: NSData)
    {
        if(responseData.length == 0)
        {
            return
        }
        
        Store.storeInstance().offers.removeAll()
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: responseData as Data, options: .allowFragments)
                as! [String:AnyObject]
            
            //print(json)
            
            if let items = json["Data"] as? [[String:AnyObject]]
            {
                for item in items
                {
                    let single = DTO_Offer.Create(dict: item as NSDictionary)
                    
                    Store.storeInstance().offers.append(single)
                    Store.storeInstance().offer = single
                }
            }
        }
        catch let error
        {
            print("error parsing DTO_Manufacture \(error)")
            return
        }
        return
    }
    
    static func Extract_DTO_Image(responseData: NSData)
    {
        if( responseData.length == 0)
        {
            return
        }
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: responseData as Data, options: .allowFragments)
                as (AnyObject)
            
            //print(json)
            
            if let item = json["Data"] as? [String:AnyObject] {
                
                let single = DTO_Image.Create(dict: item as NSDictionary)
                
                Store.storeInstance().image = single
            }
        }
        catch let error
        {
            print("error parsing DTO_Image \(error)")
            return
        }
        
        return
    }
} // end of BLL

class DTO
{
    static func parse(dict: NSDictionary, key: String)->String
    {
        if let i = dict.value(forKey: key ) as? String
        {
            return i
        }
        else
        {
            return ""
        }
    }
    
    static func parse(dict: NSDictionary, key: String)->Int
    {
        if let i = dict.value(forKey: key ) as? Int
        {
            return i
        }
        else
        {
            return 0
        }
    }
    static func parse(dict: NSDictionary, key: String)->Double
    {
        if let i = dict.value(forKey: key ) as? Double
        {
            return i
        }
        else
        {
            return 0
        }
    }
} // end of DTO

class DTO_Register : DTO
{
    var email = ""
    var fName = ""
    var lName = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var password = ""
    var phone = ""
    // var id = "" web call returns trash
    
    static func Create(dict: NSDictionary) ->DTO_Register
    {
        let dto = DTO_Register()
        
        dto.email = parse(dict: dict, key: "Email")
        dto.fName = parse(dict: dict, key: "FirstName")
        dto.lName = parse(dict: dict, key: "LastName")
        dto.latitude = parse(dict: dict, key: "Latitude")
        dto.longitude = parse(dict: dict, key: "Longitude")
        dto.password = parse(dict: dict, key: "Password")
        dto.phone = parse(dict: dict, key: "Phone")
        // dto.id = parse(dict: dict, key: "id") returns trash
        
        return dto
    }
} // end of DTO_Register

class DTO_Login : DTO
{
    // Sends and recieves back
    var email = ""
    var id : Int = 0
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var password = ""
    
    // Recieves back
    var fName = ""
    var lName = ""
    var phone = ""
    
    static func Create(dict: NSDictionary) ->DTO_Login
    {
        let dto = DTO_Login()
        
        dto.email = parse(dict: dict, key: "Email")
        dto.id = parse(dict: dict, key: "id")
        
        // Web Call does not return coordinates at all!
        //      dto.latitude = parse(dict: dict, key: "Latutude")
        //      dto.longitude = parse(dict: dict, key: "Longitude")
        
        dto.password = parse(dict: dict, key: "Password")
        
        dto.fName = parse(dict: dict, key: "FirstName")
        dto.lName = parse(dict: dict, key: "LastName")
        dto.phone = parse(dict: dict, key: "Phone")
        
        return dto
    }
} // end of DTO_Login

class DTO_Offer : DTO
{
    var dateTime = ""
    var distance : Int = 0
    var offerId : Int = 0
    var status : Int = 0
    var partId : Int = 0
    var price : Double = 0.0
    var qty : Int = 0
    var sellerId : Int = 0
    
    static func Create(dict: NSDictionary) ->DTO_Offer
    {
        let dto = DTO_Offer()
        
        dto.dateTime = parse(dict: dict, key: "DT")
        dto.distance = parse(dict: dict, key: "Distance")
        dto.offerId = parse(dict: dict, key: "Id")
        dto.status = parse(dict: dict, key: "Ostat")
        dto.partId = parse(dict: dict, key: "PartId")
        dto.price = parse(dict: dict, key: "Price")
        dto.qty = parse(dict: dict, key: "Quantity")
        dto.sellerId = parse(dict: dict, key: "SellerId")
        
        return dto
    }
}

class DTO_Image : DTO {
    
    var imageURL = ""
    
    static func Create(dict: NSDictionary) ->DTO_Image {
        
        let dto = DTO_Image()
        
        dto.imageURL = parse(dict: dict, key: "url")
        
        return dto
    }
}

//extension UIImageView {
//
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() { () -> Void in
//                self.image = image
//            }
//            }.resume()
//    }
//
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }
//}

//class DTO_Transaction : DTO {
//
//
//
//    static func Create(dict: NSDictionary) ->DTO_Transaction {
//        let dto = DTO_Transaction()
//
//
//
//        return dto
//    }
//}

