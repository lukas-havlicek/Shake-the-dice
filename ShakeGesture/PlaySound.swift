//
//  PlaySound.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 11/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print(error.localizedDescription)
    }
  }
}
