//
//  OCKSliderButton.swift
//
//
//  Created by Dylan Li on 6/27/20.
//  Copyright © 2020 NetReconLab. All rights reserved.
//

#if !os(watchOS)

import SwiftUI

struct SliderButton: View {
    
    @Environment(\.careKitStyle) private var style
    
    @Binding var value: Double
    @State private var isPressed: Bool = false
    let action: (_ value: Double) -> Void
    private let diameter: CGFloat = 60
    private let borderWidth: CGFloat = 3
    private let fontSize: CGFloat = 25
    private var foregroundColor: Color {
        isPressed ? Color(style.color.white) : .accentColor
    }
    private var buttonLogText: String {
        isPressed ? "" : loc("LOG")
    }
    private var backgroundColor: Color {
        isPressed ? .accentColor : Color(style.color.white)
    }
    private var checkmark: Image {
        Image(systemName: "checkmark")
            .resizable()
    }
    
    public var body: some View {
        Button(action: {
            if !isPressed {
                action(value)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isPressed = false
                }
                isPressed = true
            }
        }) {
            ZStack {
                Circle()
                    .frame(width: diameter, height: diameter)
                    .overlay(Circle().strokeBorder(Color.accentColor, lineWidth: borderWidth))
                    .foregroundColor(backgroundColor)
                
                checkmark
                    .frame(width: diameter * 0.4, height: diameter * 0.4)
                    .foregroundColor(foregroundColor)
                    .opacity(isPressed ? 1 : 0)
                
                Group {
                    Text(String(format: "%g", value))
                        .font(.system(size: fontSize))
                        .fontWeight(.semibold)
                        .opacity(isPressed ? 0 : 1)
                    
                    Text(buttonLogText)
                        .font(.system(size: diameter * 0.2))
                        .fontWeight(.semibold)
                        .offset(y: diameter * 0.3)
                }.foregroundColor(foregroundColor)
            }
        }
        .buttonStyle(NoHighlightStyle())
        .padding(.top)
    }
}

#endif
