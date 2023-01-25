//
//  SetViewModel.swift
//  Set
//
//  Created by Eduard on 20.12.2022.
//

import Foundation

final class SetViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var model = SetGame()
    @Published var selectedCards: Set<Card> = []
    
    var isEmpty: Bool {
        model.cards.isEmpty
    }
    
    var cards: [Card] {
        model.cardsInGame
    }
    
    var isSet: Bool? {
        model.isChosenCardsSet
    }
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func addCards() {
        model.addCards()
    }
    
    func newGame() {
        model = SetGame()
    }
}
