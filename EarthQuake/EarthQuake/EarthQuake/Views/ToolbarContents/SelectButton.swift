//
//  SelectButton.swift
//  EarthQuake
//
//  Created by 강창현 on 2023/03/13.
//

import SwiftUI

enum SelectMode {
    case active, inactive
    
    var isActive: Bool {
        self == .active
    }
}

struct SelectButton: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectButton()
    }
}
