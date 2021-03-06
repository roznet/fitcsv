//
//  File.swift
//  
//
//  Created by Brice Rosenzweig on 22/01/2021.
//

import Foundation
import FitFileParser
import RZUtilsSwift

extension FitMessage {
    
    convenience init(dataRow : [String], definitionRow: [String]) {
        var mesg_values : [FitFieldKey:Double] = [:]
        var mesg_enums : [FitFieldKey:String] = [:]
        var mesg_dates : [FitFieldKey:Date] = [:]
        
        let num_fields = (dataRow.count) / 3
        
        let mesg_name = dataRow[2]
        let mesg_num : FitMessageType = rzfit_swift_string_to_mesg_num(mesg_name)
    
        for i : Int in 1..<num_fields {
            guard let field = dataRow[safe: i*3],
                  let value = dataRow[safe: i*3+1],
                  let unit = dataRow[safe: i*3+2] else {
                break
            }
            let fitvalue = rzfit_swift_reverse_value(mesg:mesg_name, field: field, value: value)
            
            if unit != "" {
                mesg_values[field] = Double( value )
            }else{
                print( "\(field) \(value) \(unit) \(fitvalue)")
            }
        }
        
        self.init(mesg_num: mesg_num, mesg_values: mesg_values, mesg_enums : mesg_enums, mesg_dates : mesg_dates)
        
    }
}
