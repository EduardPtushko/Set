//
//  ContentView.swift
//  Set
//
//  Created by Eduard on 03.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = SetViewModel()
    
    var color: Color {
        switch model.isSet {
            case true:
                return .red
            case false:
                return .black
            default:
                return .blue
        }
    }
    
    var body: some View {
        VStack {
            if model.isSet == true {
                Text("Set!")
                    .foregroundColor(.red)
            } else if model.isSet == false {
                Text("No Set!")
                    .foregroundColor(.black)
            } else {
                Text("Empty")
                    .foregroundColor(.clear)
            }
            
            AspectVGrid(items: model.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .foregroundColor(card.isChosen ? color : .clear)
                    .padding(4)
                    .onTapGesture {
                        model.choose(card: card)
                    }
            }
            
            HStack {
                    Button {
                        withAnimation {
                            model.newGame()
                        }
                    } label: {
                        Text("New Game")
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            model.addCards()
                        }
                    } label: {
                        Text("Deal 3 More Cards")
                    }
                    .disabled(model.isEmpty)
                }
            .padding(.vertical)
           
            
        }
        .padding(.horizontal)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
