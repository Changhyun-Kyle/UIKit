//
//  QuakeMagnitude.swift
//  EarthQuake
//
//  Created by 강창현 on 2023/03/13.
//

import SwiftUI

struct QuakeMagnitude: View {
    
    var quake: Quake
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                // .formatted(.number.precision(.fractionLength(1)): 소수점 길이 설정
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title)
                    .bold()
                    .foregroundColor(quake.color)
            }
    }
}

struct QuakeMagnitude_Previews: PreviewProvider {
    static var previewQuake = Quake(magnitude: 1.0,
                                    place: "Shakey Acres",
                                    time: Date(timeIntervalSinceNow: -1000),
                                    code: "nc73649170",
                                    detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!)
    
    static var previews: some View {
        QuakeMagnitude(quake: previewQuake)
    }
}
