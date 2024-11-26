//
//  FrameworkDetailView.swift
//  Apple-Framework
//
//  Created by Nilay Jain on 23/11/24.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    var framework: Framework
    @Binding var isShowingDetailView: Bool
    @State private var isShowingsafariView = false
    
    
    var body: some View {
       
        XDismissButton(isShowingDetailView: $isShowingDetailView)
        
            Spacer()
            FrameworkTitleView(framework: framework)
            
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Button{
                isShowingsafariView = true
            }label: {
                AFButton(title: "Learn More")
                
            }
        }
        .fullScreenCover(isPresented: $isShowingsafariView, content: {
            SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
        })
    }
}

struct FrameworkDetailView_Previews: PreviewProvider{
    static var previews: some View{
        FrameworkDetailView(framework: MockData.sampleFramework, isShowingDetailView: .constant(false))
            .preferredColorScheme(.dark)
    }
}
