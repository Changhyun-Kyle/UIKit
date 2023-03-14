//
//  TestDownloader.swift
//  EarthQuake
//
//  Created by 강창현 on 2023/03/13.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        // fatalError("Unimplemented")
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakesData
    }
}
