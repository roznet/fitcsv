import XCTest
import RZUtilsSwift
import FitFileParser
@testable import FitCsv

final class fit_tests: XCTestCase {
    func findResource( name : String) -> URL{
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("samples").appendingPathComponent(name)
        return resourceURL

    }

    func testGarminSDK() {
        let manager = RegressionManager( cls: type(of: self))
        //manager.recordMode = true
        let files = [ "DeveloperData"]
        for base in files {
            let fitFileName = base + ".fit"
            let csvFileName = base + ".csv"
            
            let fitUrl = self.findResource(name: "sdk/\(fitFileName)")
            let csvUrl = self.findResource(name: "sdk/\(csvFileName)")
            let fitFile = FitFile(file: fitUrl)
            let csvFile = FitFile(csvUrl: csvUrl)
            XCTAssertNotNil(fitFile, "Create fitFile for \(base)")
            XCTAssertNotNil(csvFile, "Create csvFile for \(base)")
            if let fitFile = fitFile {
                let messages : [FitMessage] = fitFile.messages
                let retrieved = try? manager.retrieve(object: messages, identifier: base)
                XCTAssertNotNil(retrieved, "Found reg object for \(base)")
                if let retrieved = retrieved {
                    var matching_count = 0
                    var diff_count = 0
                    for (one_retrieved, one_message) in zip(retrieved, messages) {
                        if one_retrieved == one_message {
                            matching_count+=1
                            XCTAssertEqual(one_retrieved, one_message)
                        }else{
                            if diff_count == 0 {
                                // only assert first error, otherwise too much output
                                XCTAssertEqual(one_retrieved, one_message)
                            }
                            diff_count+=1
                        }
                    }
                    XCTAssertEqual(diff_count, 0, "regression \(base) all matched")
                }
            }
        }
    }

    static var allTests = [
        ("testGarminSDK", testGarminSDK),
    ]
}
