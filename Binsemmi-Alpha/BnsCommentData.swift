//
//  BnsDriverComments.swift
//  Binsemmi
//
//  Created by Deniz on 19.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation

class BnsCommentData
{
    private var bCommentId : Int = 0
    private var bPlateNo : String = ""
    private var bStreet : String = ""
    private var bTown : String = ""
    private var bRegion : String = ""
    private var bCity : String = ""
    private var bComment : String = ""
    private var bCommentator : String = ""
    private var bDriverPoint : Int = 0
    
    public init(CommentId : Int,
                PlateNo : String,
                Street : String,
                Town : String,
                Region : String,
                City : String,
                Comment : String,
                Commentator : String,
                DriverPoint : Int)
    {
        bCommentId = CommentId
        bPlateNo = PlateNo
        bStreet = Street
        bTown = Town
        bRegion = Region
        bCity = City
        bComment = Comment
        bCommentator = Commentator
        bDriverPoint = DriverPoint
    }
    
    public func GetCommentId() -> Int
    {
        return bCommentId
    }
    
    public func GetPlateNo() -> String
    {
        return bPlateNo
    }
    
    public func GetStreet() -> String
    {
        return bStreet
    }
    
    public func GetTown() -> String
    {
        return bTown
    }
    
    public func GetRegion() -> String
    {
        return bRegion
    }
    
    public func GetCity() -> String
    {
        return bCity
    }
    
    public func GetComment() -> String
    {
        return bComment
    }
    
    public func GetCommentator() -> String
    {
        return bCommentator
    }
    
    public func GetDriverPoint() -> Int
    {
        return bDriverPoint
    }
    
}
