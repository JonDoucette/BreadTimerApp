//
//  EnumHelpers.swift
//  BreadTimer
//
//  Created by Jon Doucette on 12/28/23.
//
//Contains Common Enums for general bake and proof times

import Foundation

enum CommonStretch: String, CaseIterable {
    case minute15 = "15 minutes"
    case minute30 = "30 minutes"
    case minute45 = "45 minutes"

    var number: Int {
        switch self {
            case .minute15: return 15
            case .minute30: return 30
            case .minute45: return 45
        }
    }
}

enum CommonBulk: String, CaseIterable {
    case hour6 = "6 hours"
    case hour12 = "12 hours"
    case hour24 = "24 hours"


    var number: Int {
        switch self {
            case .hour12: return 12
            case .hour24: return 24
            case .hour6: return 6
        }
    }
}

enum CommonProof: String, CaseIterable{
    case hour12 = "12 hours"
    case hour24 = "24 hours"
    case hour36 = "36 hours"
    case hour48 = "48 hours"

    var number: Int {
        switch self {
            case .hour12: return 12
            case .hour24: return 24
            case .hour36: return 36
            case .hour48: return 48
        }
    }
}

enum CommonOven: String, CaseIterable {
    case minute30 = "30 minutes"
    case minute45 = "45 minutes"
    case minute60 = "60 minutes"

    var number: Int {
        switch self {
            case .minute30: return 30
            case .minute45: return 45
            case .minute60: return 60
        }
    }
}

enum CommonDesiredTime: String, CaseIterable {
    
    case morning = "Morning"
    case noon = "Noon"
    case night = "Evening"
    
    //Returns the hour of the day
    var number: Int {
        switch self {
            case .morning: return 8
            case .noon: return 12
            case .night: return 5
        }
    }
    
    
}
