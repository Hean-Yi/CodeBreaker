//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 梁航川 on 2025/12/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PegsShow(Color: [.red, .green, .blue, .yellow])
            PegsShow(Color: [.red, .red, .blue, .yellow])
            PegsShow(Color: [.red, .blue, .blue, .yellow])
        }
        .padding()
    }
    func PegsShow(Color colors: Array<Color>) -> some View{
        HStack{
            ForEach(colors.indices, id: \.self){ index in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(colors[index])
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 6)
                    .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(.white.opacity(0.6), lineWidth: 1)
                                    .blur(radius: 0.5)
                            )
            }
            MatchPegs(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}



#Preview {
    ContentView()
}
