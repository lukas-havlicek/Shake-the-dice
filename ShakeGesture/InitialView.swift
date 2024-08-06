//
//  InitialView.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 18/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import SwiftUI

struct InitialView: View {
  @State private var offsetX: CGFloat = 0
  @State private var offsetY: CGFloat = 0
  @State private var angle: Double = 0
  @State private var diceOffsetX: CGFloat = -22
  @State private var diceOffsetY: CGFloat = -20
  @State private var diceAngle: Double = 0
  
  var body: some View {
    ZStack {
      Color.initBackground.edgesIgnoringSafeArea(.all)
      Image("iPhoneHand")
        .resizable()
        .scaledToFit()
        .frame(width: 150)
        .offset(x: offsetX, y: offsetY)
        .rotationEffect(.degrees(angle), anchor: .bottomTrailing)
        .onAppear {
          self.shake()
        }
      Image("6")
        .resizable()
        .frame(width: 15, height: 15)
        .rotationEffect(.degrees(diceAngle))
        .offset(x: diceOffsetX, y: diceOffsetY)
    }
  }
  func shake() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      withAnimation(.easeInOut(duration: 0.3)) {
        self.offsetX = -30
        self.offsetY = 10
        self.angle = -10
        self.diceOffsetX = -62
        self.diceOffsetY = -13
        self.diceAngle = 70
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      withAnimation(.easeInOut(duration: 0.5)) {
        self.offsetX = 40
        self.offsetY = -10
        self.angle = 10
        self.diceOffsetX = 24
        self.diceOffsetY = -13
        self.diceAngle = -70
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
      withAnimation(.easeInOut(duration: 0.3)) {
        self.offsetX = 0
        self.offsetY = 0
        self.angle = 0
        self.diceOffsetX = -22
        self.diceOffsetY = -20
        self.diceAngle = 0
      }
    }
  }
}

struct InitialView_Previews: PreviewProvider {
  static var previews: some View {
    InitialView()
  }
}
