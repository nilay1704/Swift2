//
//  XDismissButton.swift
//  Apple-Framework
//
//  Created by Nilay Jain on 23/11/24.
//

import SwiftUI

struct XDismissButton: View {
    
    @Binding var isShowingDetailView = Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button{
                    isShowingDetailView = false
                }label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .imageScale(.large)
                        .frame(width:44 , height: 44)
                }
            }
            .padding()
        }
    }
    
    
    #Preview {
        XDismissButton(isShowingDetailView: .constant(false))
    }
    
}
