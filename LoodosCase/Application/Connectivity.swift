//
//  Connectivity.swift
//  LoodosCase
//
// Created by Ayşe Yürek on 02.04.2022.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
