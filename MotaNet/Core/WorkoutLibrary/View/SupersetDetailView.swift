//
//  SupersetDetailView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

struct SupersetDetailView: View {
    @State var viewModel: SupersetDetailViewModel
    @Binding var isWorkoutEdited: Bool
    
    init(supersetEditContext: SupersetEditContext) {
        _viewModel = State(initialValue: SupersetDetailViewModel(superset: supersetEditContext.superset))
        self._isWorkoutEdited = supersetEditContext.isWorkoutEdited
    }
    
    var body: some View {
        List {
            ForEach(viewModel.superset.rounds) { round in
                VStack(alignment: .listRowSeparatorLeading) {
                    ForEach(round.singlesets) { singleset in
                        SinglesetView(singleset: singleset, isWorkoutEdited: $isWorkoutEdited)
                    }
                    HStack {
                        Spacer()
                        Text("Rest")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        TextField(
                            "", text: Binding{
                                
                                return String(round.rest)
                                
                            } set: { rest in
                                round.rest = Int(rest) ?? 0
                                isWorkoutEdited = true
                            }
                        )
                        .font(.footnote)
                        .fixedSize()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        Spacer()
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.removeRound(at: indexSet)
                isWorkoutEdited = true
            }
            Button {
                viewModel.addRound()
                isWorkoutEdited = true
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Add round")
                    Spacer()
                }
            }
            
            
        }
        .listStyle(.inset)
    }
}

#Preview {
    SupersetDetailView(supersetEditContext: SupersetEditContext(superset: WorkoutTemplate.MOCK_WORKOUTS[1].supersets[0], isWorkoutEdited: .constant(false)))
}
