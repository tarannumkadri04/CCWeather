//
//  LoaderView.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 30/05/23.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
