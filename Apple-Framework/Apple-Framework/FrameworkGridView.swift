//
//  FrameworkGridView.swift
//  Apple-Framework
//
//  Created by Nilay Jain on 22/11/24.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
 
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: viewModel.columns){
                    ForEach(MockData.frameworks){ Framework in
                        FrameworkTitleView(framework: Framework)
                            .onTapGesture {
                                viewModel.selectedFramework = Framework
                            }
                        
                    }
                }
            }
  
        .navigationTitle("🍒 App Gallary")
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            FrameworkDetailView(framework: viewModel.selectedFramework!,
                                isShowingDetailView: $viewModel.isShowingDetailView)
        }
        }
    }
}


#Preview {
    FrameworkGridView()
        .preferredColorScheme(.dark)
}

