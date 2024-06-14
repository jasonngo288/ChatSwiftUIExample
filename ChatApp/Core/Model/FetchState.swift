//
//  FetchState.swift
//  ChatApp
//
//  Created by Jason Ngo on 03/06/2024.
//

import Foundation

enum FetchState: Comparable {
  case start
  case isLoading
  case loadedAll
  case error(String)
}
