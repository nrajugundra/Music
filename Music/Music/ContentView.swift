//
//  ContentView.swift
//  Music
//
//  Created by Raju on 24/09/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var isPlaying: Bool = false
    @State private var currentTime: TimeInterval = 0.0
    @State private var totalTime: TimeInterval = 0.0
    @State private var player: AVAudioPlayer?
     
    var body: some View {
        ZStack {
            Color.blue.opacity(0.55).ignoresSafeArea(.all)
            
            VStack {
                Image(systemName: isPlaying ? "pause.circle" : "play.circle").font(.largeTitle)
                    .onTapGesture {
                        isPlaying ? pause() : play()
                    }
            }
        }.onAppear(perform: {
            setupAudio()
        })
    }
    
//    Functions for Audio player
    private func setupAudio() {
        guard let path = Bundle.main.url(forResource: "10", withExtension: ".mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: path)
            player?.prepareToPlay()
        }
        catch {
            print("failed to load audio file")
        }
    }
    
    func play() {
        isPlaying.toggle()
        player?.play()
    }
    
    func pause() {
        isPlaying.toggle()
        player?.pause()
    }
    
}

#Preview {
    ContentView()
}
