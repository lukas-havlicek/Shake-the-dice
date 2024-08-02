//
//  MovingDiceView.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 11/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import SwiftUI
import AVFoundation

struct MovingDiceView: View {
  @State private var rolledNumbers: [Int] = []
  @State private var diceOne = String(Int.random(in: 1..<7))
  @State private var diceTwo = String(Int.random(in: 1..<7))
  @State private var scaleOneX: CGFloat = 1
  @State private var scaleOneY: CGFloat = 1
  @State private var scaleTwoX: CGFloat = 1
  @State private var scaleTwoY: CGFloat = 0
  @State private var pointOneX: CGFloat = 0
  @State private var pointOneY: CGFloat = 1
  @State private var pointTwoX: CGFloat = 0
  @State private var pointTwoY: CGFloat = 0
  @State private var stopRolling = false
  
  func rolling() {
    if stopRolling { return }
    stopRolling = true
    playSound(sound: "dice", type: "m4a")
    rolledNumbers = randoms()
    diceOne = String(rolledNumbers[0])
    diceTwo = String(rolledNumbers[1])
    pointOneX = 0
    pointOneY = 1
    pointTwoX = 0
    pointTwoY = 0
    scaleOneX = 1
    scaleOneY = 1
    scaleTwoX = 1
    scaleTwoY = 0
    withAnimation(.linear(duration: 0.5)) {
      scaleOneY = 0
      scaleTwoY = 1
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.diceOne = String(self.rolledNumbers[2])
      self.pointOneX = 0
      self.pointOneY = 1
      self.pointTwoX = 1
      self.pointTwoY = 1
      self.scaleOneX = 0
      self.scaleOneY = 1
      withAnimation(.linear(duration: 0.5)) {
        self.scaleTwoX = 0
        self.scaleOneX = 1
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.diceTwo = String(self.rolledNumbers[3])
      self.pointOneX = 0
      self.pointOneY = 0
      self.pointTwoX = 1
      self.pointTwoY = 1
      self.scaleTwoX = 1
      self.scaleTwoY = 0
      withAnimation(.linear(duration: 0.5)) {
        self.scaleOneY = 0
        self.scaleTwoY = 1
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.stopRolling = false
    }
  }
  func randoms() -> [Int] {
    var numbers: [Int] = []
    for _ in 1...4 {
      var number: Int
      repeat {
        number = Int.random(in: 1..<7)
      } while numbers.contains(number)
      numbers.append(number)
    }
    return numbers
  }
  
  var body: some View {
    ZStack {
      Image(diceOne)
        .resizable()
        .frame(width: 100, height: 100)
        .scaledToFit()
        .scaleEffect(x: scaleOneX, y: scaleOneY, anchor: UnitPoint(x: pointOneX, y: pointOneY))
      Image(diceTwo)
        .resizable()
        .frame(width: 100, height: 100)
        .scaledToFit()
        .scaleEffect(x: scaleTwoX, y: scaleTwoY, anchor: UnitPoint(x: pointTwoX, y: pointTwoY))
    }
    .onAppear {
      self.rolling()
    }
    .onReceive(messagePublisher) { _ in
      self.rolling()
    }
  }
}

struct MovingDiceView_Previews: PreviewProvider {
  static var previews: some View {
    MovingDiceView()
  }
}
