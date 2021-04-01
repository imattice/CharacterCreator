//
//  CreationChoiceViews.swift
//  Source
//
//  Created by Ike Mattice on 3/22/21.
//

import SwiftUI

///A default CreationChoiceView  that displays an option for a single choice
struct CreationChoiceView: View {
    @State var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        self._text = State(initialValue: text)
    }
}

///A CreationView for displaying Ability Score choices
struct CreationStatView: View {
    @State var title: String
    let labels: [String] = [
    "str", "con", "dex", "cha", "int", "wis"]

    var body: some View {
        VStack {
            Text(title)
            HStack(spacing: 40) {
//                ForEach(scoresLabels.enumerated()) { }
//                VStack(spacing: 20) {
//                    StatLabel(title: "str")
//                    StatLabel(title: "con")
//                }
                VStack(spacing: 20) {
                    StatLabel(title: "str")
                    StatLabel(title: "con")
                }
                VStack(spacing: 20) {
                    StatLabel(title: "dex")
                    StatLabel(title: "cha")

                }
                VStack(spacing: 20) {
                    StatLabel(title: "int")
                    StatLabel(title: "wis")

                }
            }
            .padding(4)
        }
    }
    
    init(_ title: String) {
        self._title = State(initialValue: title)
    }
}

struct StatLabel: View {
    let title: String
    @State var value: Int = 0
    let style: LabelStyle = .vertical
    
    var body: some View {
        switch style {
        case .horizontal:
        HStack {
            Text("\(title.uppercased()): ")
            Text(String(format: "%02d", value))
        }
        case .vertical:
            VStack {
                Text("\(title.uppercased()) ")
                Text(String(format: "%02d", value))
            }
        }
    }
    
    enum LabelStyle {
        case horizontal, vertical
    }
}

struct CreationChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreationChoiceView(CreationProgression().steps[0])
                .previewLayout(.sizeThatFits)
            CreationChoiceView(CreationProgression().steps[1])
                .previewLayout(.sizeThatFits)
            CreationChoiceView(CreationProgression().steps[2])
                .previewLayout(.sizeThatFits)
            CreationStatView(CreationProgression().steps[4])
                .previewLayout(.sizeThatFits)
            CreationChoiceView(CreationProgression().steps[7])
                .previewLayout(.sizeThatFits)
        }
        .padding()
        .font(.system(size: 24))
        .lineLimit(nil)
//            .background(Color.blue)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 5))
    }
}
