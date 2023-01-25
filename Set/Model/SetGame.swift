//
//  SetGame.swift
//  Set
//
//  Created by Eduard on 11.12.2022.
//

import Foundation
import SwiftUI

struct SetGame {
    private(set) var cards: [Card] = []
    private(set) var cardsInGame: [Card] = []
    private(set) var selectedCards: Set<Card> = []
    private(set) var isChosenCardsSet: Bool?
    
    init() {
        var cards: [Card] = []
        for quantity in CardQuantity.allCases {
            for shape in CardShape.allCases {
                for color in CardColor.allCases {
                    for shade in CardShade.allCases {
                        let card = Card(color: color, shape: shape, shade: shade, quantity: quantity)
                        cards.append(card)
                    }
                }
            }
        }
        
        self.cards = cards
        self.cards.shuffle()
        self.cardsInGame = Array(self.cards.suffix(12))
        self.cards.removeLast(12)
    }
    
    mutating func choose(card: Card) {
        if isChosenCardsSet == true {
            isChosenCardsSet = nil
            cardsInGame = cardsInGame.filter({card in !card.isChosen})
            self.addCards()
            
        } else if isChosenCardsSet == false {
            isChosenCardsSet = nil
  
          cardsInGame = cardsInGame.map {card in
                var copyCard = card
                copyCard.isChosen = false
                return copyCard
                
            }
        } else {
            
        }
        
        guard let cardIndex = cardsInGame.firstIndex(where: { $0.id == card.id}) else {
            return
        }

        cardsInGame[cardIndex].isChosen.toggle()
        let chosenCards = cardsInGame.filter({card in card.isChosen})
        
        if chosenCards.count == 3 {
            isChosenCardsSet = isSet(for: chosenCards)
            return
        }
    }
    
    mutating func addCards() {
        if isChosenCardsSet == true {
            isChosenCardsSet = nil
            cardsInGame = cardsInGame.filter({card in !card.isChosen})
        }
        guard self.cards.count >= 3 else { return }
        self.cardsInGame.append(contentsOf:  self.cards.suffix(3)) 
        self.cards.removeLast(3)
    }
   
//
//    func isAllowed(cards: [Card]) -> Bool {
//        let touchedCards = cards.filter {
//            $0.isChosen
//        }
//        if touchedCards.count >= 3 {
//            return false
//        }
//
//        return true
//    }
    
    func isSet(for cards: [Card]) -> Bool {
        let isQuantitiesFulfilling = isFulfilling(cards: cards, type: \.quantity)
        let isColorsFulfilling = isFulfilling(cards: cards, type: \.color)
        let isShapesFulfilling = isFulfilling(cards: cards, type: \.shape)
        let isShadesFulfilling = isFulfilling(cards: cards, type: \.shade)

        return isQuantitiesFulfilling && isColorsFulfilling && isShapesFulfilling && isShadesFulfilling
    }
    
    
    func isFulfilling<K>(cards: [Card], type: KeyPath<Card, K>) -> Bool where K: Equatable {
        let elements = cards.reduce(into: []) { partialResult, card in
            partialResult.append(card[keyPath: type])
        }
        
        let isSatisfy = elements.allSatisfy({ element in
            elements[0] == element
        }) || isAllDifferent(elements: elements)
        
        return isSatisfy
    }
    
    func isAllDifferent<T>(elements: [T]) -> Bool where T: Equatable {
        if elements[0] == elements[1] || elements[1] == elements[2] || elements[0] == elements[2] {
            return false
        }
        return true
    }
    
    
    struct Card:Identifiable, Hashable {
        let id = UUID()
        var isMatched = false
        var isChosen = false
        var color: CardColor
        var shape: CardShape
        var shade: CardShade
        var quantity: CardQuantity
        
        init(color: CardColor, shape: CardShape, shade: CardShade, quantity: CardQuantity) {
            self.color = color
            self.shape = shape
            self.shade = shade
            self.quantity = quantity
        }
    }
}

let sampleCards: [SetGame.Card] = [
    SetGame.Card(color: .red, shape: .oval, shade: .none, quantity: .one),
    SetGame.Card(color: .green, shape: .diamond, shade: .striped, quantity: .two),
    SetGame.Card(color: .purple, shape: .squiggle, shade: .solid, quantity: .three)
]


struct AnyShape: InsettableShape {
    var insetAmount = 0.0
    func inset(by amount: CGFloat) -> some InsettableShape {
        var oval = self
        oval.insetAmount += amount
        return oval
    }

    private let path: (CGRect) -> Path

    func path(in rect: CGRect) -> Path {
        path(rect)
    }

    init<T: Shape>(_ shape: T) {
        path = { rect in
            shape.path(in: rect)
        }
    }
}

extension Shape {
    func anyShape() -> AnyShape {
        AnyShape(self)
    }
}

enum CardShape:String, CaseIterable {
    case oval
    case diamond
    case squiggle
    
    var shape: some InsettableShape {
        switch self {
            case .oval:
                return Ellipse().anyShape()
            case .diamond:
                return Diamond().anyShape()
            case .squiggle:
               return Squiggle().anyShape()
        }
    }
}

enum CardShade:String, CaseIterable {
    case none
    case striped
    case solid
}

enum CardQuantity:Int, CaseIterable, Identifiable {
    case one = 1
    case two
    case three
    
    var id: Int {
        self.rawValue
    }
}

enum CardColor:String, CaseIterable {
    case red
    case green
    case purple
    
    var color: Color {
        switch self {
            case .red:
               return Color.red
            case .green:
               return Color.green
            case .purple:
               return Color.purple
        }
    }
}
