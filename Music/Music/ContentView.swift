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
                    }.foregroundColor(.white)
                Slider(value: Binding(get: {
                    currentTime
                }, set: { new in
                    seekAudio(to: new)
                }), in: 0...totalTime)
                .accentColor(.white)
                .padding()
                HStack {
                    Text(timeString(time: currentTime))
                    .foregroundColor(.white)
                    Spacer()
                    Text(timeString(time: totalTime))
                        .foregroundColor(.white)
                }.padding(.horizontal)
            }
        }.onAppear(perform: {
            setupAudio()
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            updateProgress()
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
            totalTime = player?.duration ?? 0.0
        }
        catch {
            print("failed to load audio file")
        }
    }
    
    private func play() {
        isPlaying.toggle()
        player?.play()
    }
    
    private func pause() {
        isPlaying.toggle()
        player?.pause()
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time)/60
        let seconds = Int(time)%60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
        if Int(currentTime) == Int(totalTime) {
            isPlaying.toggle()
        }
    }
}

#Preview {
    ContentView()
}
