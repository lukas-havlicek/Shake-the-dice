//
//  TimerManager.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 12/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
  @Published var delayRolling = false
  var timer = Timer()
  func delay() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
      self.delayRolling = true
    })
  }
  func delayNeg() {
    self.delayRolling = false
  }
}
