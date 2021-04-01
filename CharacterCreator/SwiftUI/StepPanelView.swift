//
//  StepPanelView.swift
//  Source
//
//  Created by Ike Mattice on 3/24/21.
//

import SwiftUI

struct StepPanelView: View {
    @State var progression: CreationProgression = CreationProgression()
    
    var body: some View {
        ScrollView {
            ForEach(progression.steps, id: \.self) { step in
                CreationChoiceView(step)

            }
        }
    }
    ///Proceed to the next step in the creation process
    func progress() {
        
    }
    ///Revert to the previous step in the creation process
    func regress() {
        
    }
}

struct StepPanelView_Previews: PreviewProvider {
    static var previews: some View {
        StepPanelView()
            .previewLayout(.sizeThatFits)
    }
}
