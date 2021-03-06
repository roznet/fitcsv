import Foundation
import FitFileParser
import SwiftCSV

extension FitFile {
    
    convenience init(csvUrl: URL){
        var messages : [FitMessage] = []
        if let csv : CSV = try? CSV(url: csvUrl) {
            var definitions : [Int:[String]] = [:]
            try? csv.enumerateAsArray { row in
                if let local_mesg = row[safe: 1],
                   let local_mesg_num = Int( local_mesg ){
                    if row[0] == "Definition" {
                        definitions[local_mesg_num] = row
                    }else if let definition = definitions[local_mesg_num] {
                        let message = FitMessage(dataRow: row, definitionRow: definition)
                        messages.append(message)
                    }
                }
            }
        }
        self.init(messages : [] )
    }
}
