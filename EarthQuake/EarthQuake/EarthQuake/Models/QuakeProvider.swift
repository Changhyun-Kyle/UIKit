//
//  QuakeProvider.swift
//  EarthQuake
//
//  Created by 강창현 on 2023/03/13.
//

import Foundation

class QuakeProvider: ObservableObject {
    
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuake() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
