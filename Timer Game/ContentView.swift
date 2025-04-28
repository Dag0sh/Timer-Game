//
//  ContentView.swift
//  Timer Game
//
//  Created by Dagosh on 22.04.2025.
//

import SwiftUI

struct ContentView: View {
    let defaultTime: CGFloat = 10
    @State private var timerstate = false
    @State private var countdowntimestring = ""
    @State private var countdowntime: CGFloat = 10.0
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    
    let strokeStyle = StrokeStyle(lineWidth: 15, lineCap: .round)
    
    
    var body: some View {
        VStack{
//            TextField("Time", text: $countdowntimestring)
//            
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal, 20)
//                .padding(.bottom)
//            
            //let countdowntime = CGFloat(Double(countdowntimestring) ?? 0.0)
            let countdownColor: Color = {
                switch (countdowntime) {
                case 6.0...: return Color.green
                case 3.0...: return Color.yellow
                default: return Color.red
                }
            }()
            let buttonIcon = timerstate ? "pause.rectangle.fill" : "play.rectangle.fill"
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: strokeStyle)
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTime - countdowntime) / defaultTime))
                    .stroke(countdownColor, style: strokeStyle)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: countdowntime)
                HStack(spacing: 25) {
                    Label("", systemImage: buttonIcon)
                        .foregroundColor(.black).font(.title)
                        .frame(width: 40, height: 50)
                        .onTapGesture(perform: { timerstate.toggle() })
                    Text(String(format: "%.2f", countdowntime))
                        .font(.largeTitle)
                        .frame(width: 90, height: 50)
                    Label("", systemImage: "gobackward")
                        .foregroundColor(.red)
                        .font(.title)
                        .frame(width: 40, height: 50)
                        .onTapGesture(perform: {
                            timerstate = false
                            countdowntime = defaultTime
                        })
                }
            }.frame(width: 300, height: 300)
                .onReceive(timer, perform: { _ in
                    guard timerstate else { return }
                    if countdowntime > 0 {
                        countdowntime -= 0.01
                    } else {
                        timerstate = false
                        countdowntime = defaultTime
                    }
                })
        }}}

#Preview {
    ContentView()
}
