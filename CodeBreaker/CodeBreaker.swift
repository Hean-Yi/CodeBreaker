//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by 梁航川 on 2026/2/11.
//

import Foundation
import SwiftUI

typealias Peg = Color
struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guessCode: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.blue, .red, .green, .yellow]){
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    mutating func attemptGuess() {
        var attempt = guessCode
        attempt.kind = .attempt(guessCode.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guessCode.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let nextPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guessCode.pegs[index] = nextPeg
        } else{
            guessCode.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = .clear
    enum Kind: Equatable {
        case guess
        case master
        case attempt([Match])
        case unknown
    }
    
    var matches: [Match] {
        switch kind{
        case .attempt(let matches): return matches
        default: return []
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]){
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array.init(repeating: .nomatch, count: self.pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed(){
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices.reversed() {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[matchIndex] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
    
}
