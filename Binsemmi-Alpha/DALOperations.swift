//
//  DALOperations.swift
//  Binsemmi
//
//  Created by Deniz on 21.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DALOperations
{
    private final var linkBlock : String = "cf175224"
    
    private var comments : [BnsCommentData] = []
    
    public func getDriverComments() -> [BnsCommentData]
    {
        return comments
    }
    
    public func setDriverComments(plateNo: String, completionHandler: ((UIBackgroundFetchResult) -> Void)!)
    {
        Alamofire.request("http://" + linkBlock + ".ngrok.io/BinsemmiWebApp/webresources/entities.bnscommentdata/getDriverComments/" + plateNo).responseJSON
            {
                response in
                print(response.request!)  // original URL request
                print(response.response!) // HTTP URL response
                print(response.data!)     // server data
                print(response.result)   // result of response serialization
                
                switch response.result
                {
                case .success(let JSON):
                    if JSON is NSNull
                    {
                        completionHandler(UIBackgroundFetchResult.newData)
                    }
                    else
                    {
                        let jsonDict = JSON as! [NSDictionary]
                        for dict in jsonDict
                        {
                        let bean = BnsCommentData(CommentId: dict["BCommentId"] as! Int,
                                                         PlateNo: dict["BPlateNo"] as! String,
                                                         Street: dict["BStreet"] as! String,
                                                         Town: dict["BTown"] as! String,
                                                         Region: dict["BRegion"] as! String,
                                                         City: dict["BCity"] as! String,
                                                         Comment: dict["BComment"] as! String,
                                                         Commentator: dict["BCommentator"] as! String,
                                                         DriverPoint: dict["BDriverPoint"] as! Int)
                            self.comments.append(bean)
                        }
                        completionHandler(UIBackgroundFetchResult.newData)
                    }
                    break
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    break
                }
        }
    }
    
    public func insertDriver(bdc: BnsCommentData, completionHandler: ((UIBackgroundFetchResult) -> Void)!)
    {
        let params: [String: AnyObject] =
        [
            "BPlateNo" : bdc.GetPlateNo() as AnyObject,
            "BStreet" : bdc.GetStreet() as AnyObject,
            "BTown" : bdc.GetTown() as AnyObject,
            "BRegion" : bdc.GetRegion() as AnyObject,
            "BCity" : bdc.GetCity() as AnyObject,
            "BComment" : bdc.GetComment() as AnyObject,
            "BCommentator" : bdc.GetCommentator() as AnyObject,
            "BDriverPoint" : bdc.GetDriverPoint() as AnyObject,
        ]
        
        Alamofire.request("http://" + linkBlock + ".ngrok.io/BinsemmiWebApp/webresources/entities.bnscommentdata/insertDriver/",
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default).responseJSON
            {
                response in
                print(response)
                
                switch response.result
                {
                    case .success( _):
                        print("Bilgi mesajı: " + "Plaka ekleme başarılı.")
                        completionHandler(UIBackgroundFetchResult.newData)
                        break
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        break
                }
            }
        
    }
    
}

