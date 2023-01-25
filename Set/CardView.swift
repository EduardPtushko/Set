//
//  CardView.swift
//  Set
//
//  Created by Eduard on 20.12.2022.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
  
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 4) {
                HStack {
                    Spacer()
                }
                Spacer()
                ForEach(0..<card.quantity.rawValue) { _ in
                    card.shape.shape
                        .strokeBorder(lineWidth: 4)
                        .aspectRatio(1.5, contentMode: .fit)
                        .overlay {
                                if card.shade.rawValue == "striped" {
                                    Stripes()
                                        .stroke(lineWidth: 2)
                                } else if card.shade.rawValue == "solid"{
                                    card.shape.shape
                                        .fill()
                                }
                            
                        }
                        .clipShape(card.shape.shape)
                        .foregroundColor(card.color.color)

                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .background(.ultraThickMaterial)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 1)
                    
                    
        }
           
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: sampleCards[0])
        CardView(card: sampleCards[1])
        CardView(card: sampleCards[2])
    }
}
