//
//  Shapes.swift
//  Set
//
//  Created by Eduard on 09.12.2022.
//

import SwiftUI


struct Shapes: View {
    @State private var isRotating = false
    
    var body: some View {
        VStack {
            Squiggle()
        }
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}

struct Stripes: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width / 9
        let height = rect.size.height
        
        for index in 1..<9 {
            path.move(to: CGPoint(x: width * CGFloat(index), y: 0))
            path.addLine(to: CGPoint(x: width * CGFloat(index), y: height))
        }
        
        return path
    }
}


struct Diamond: InsettableShape {
    var insetAmount = 0.0
    func inset(by amount: CGFloat) -> some InsettableShape {
        var oval = self
        oval.insetAmount += amount
        return oval
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addLines([
            CGPoint(x: rect.width / 2, y: 0),
            CGPoint(x: rect.width, y: rect.height / 2),
            CGPoint(x: rect.width / 2, y: rect.height),
            CGPoint(x: 0, y: rect.height / 2),
        ])
        path.closeSubpath()
        
        return path
    }
}


struct Squiggle: InsettableShape {
    var insetAmount = 0.0
    func inset(by amount: CGFloat) -> some InsettableShape {
        var oval = self
        oval.insetAmount += amount
        return oval
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.10234*width, y: 0.11265*height))
        path.addCurve(to: CGPoint(x: 0.0546*width, y: 0.97538*height), control1: CGPoint(x: -0.04232*width, y: 0.29951*height), control2: CGPoint(x: -0.00326*width, y: 0.88513*height))
        path.addCurve(to: CGPoint(x: 0.33249*width, y: 0.84018*height), control1: CGPoint(x: 0.11246*width, y: 1.06562*height), control2: CGPoint(x: 0.1994*width, y: 0.8147*height))
        path.addCurve(to: CGPoint(x: 0.84694*width, y: 0.93434*height), control1: CGPoint(x: 0.46557*width, y: 0.86566*height), control2: CGPoint(x: 0.683*width, y: 1.09571*height))
        path.addCurve(to: CGPoint(x: 0.94569*width, y: 0.01985*height), control1: CGPoint(x: 1.01089*width, y: 0.77296*height), control2: CGPoint(x: 1.03634*width, y: 0.08355*height))
        path.addCurve(to: CGPoint(x: 0.68061*width, y: 0.15973*height), control1: CGPoint(x: 0.85504*width, y: -0.04385*height), control2: CGPoint(x: 0.8272*width, y: 0.15548*height))
        path.addCurve(to: CGPoint(x: 0.10234*width, y: 0.11265*height), control1: CGPoint(x: 0.53403*width, y: 0.16398*height), control2: CGPoint(x: 0.31064*width, y: -0.15642*height))
        path.closeSubpath()
        
        
        return path
    }
}
