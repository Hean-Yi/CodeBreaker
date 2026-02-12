//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 梁航川 on 2025/12/28.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game: CodeBreaker = CodeBreaker()
    var body: some View {
        VStack {
            view(code: game.masterCode)
            view(code: game.guessCode)
            ScrollView{
                ForEach(game.attempts.indices.reversed(), id: \.self){ index in
                    view(code: game.attempts[index])
                }
            }
        }
        .padding()
    }
    var guessButton: some View {
        Button("Guess"){
            withAnimation{
                game.attemptGuess()
            }
        }
        .font(.system(size: 42))
        .minimumScaleFactor(0.1)
    }
    func view(code: Code) -> some View{
        HStack{
            ForEach(code.pegs.indices, id: \.self){ index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay{
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
                    .foregroundStyle(code.pegs[index])
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 6)
                    .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(.white.opacity(0.6), lineWidth: 1)
                                    .blur(radius: 0.5)
                            )
            }
            MatchPegs(matches: code.matches)
                .overlay{
                    if code.kind == .guess{
                        guessButton
                    }
                }
        }
    }
}



#Preview {
    CodeBreakerView()
}
