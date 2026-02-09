//
//  MatchPegs.swift
//  CodeBreaker
//
//  Created by 梁航川 on 2026/2/8.
//
import SwiftUI

enum Match{
    case nomatch
    case exact
    case inexact
}

struct MatchPegs: View {
    var matches: [Match]
    var body: some View{
        VStack{
            HStack{
                MatchMaker(peg: 0)
                MatchMaker(peg: 1)
            }
            HStack(spacing: 0){
                MatchMaker(peg: 2)
                MatchMaker(peg: 3)
            }
        }
    }
    func MatchMaker(peg: Int) -> some View {
        let exactMatch: Int = matches.count(where:{
            match in match == .exact
        })
        let foundMatch: Int = matches.count(where:{
            match in match != .nomatch
        })
        return Circle()
            .fill(exactMatch > peg ? Color.primary : Color.clear)
            .strokeBorder(foundMatch > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchPegs(matches: [.exact, .inexact, .nomatch, .exact])
}
