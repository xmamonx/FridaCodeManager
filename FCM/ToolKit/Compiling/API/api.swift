 /* 
 api.swift 

 Copyright (C) 2023, 2024 SparkleChan and SeanIsTethered 
 Copyright (C) 2024 fridakitten 

 This file is part of FridaCodeManager. 

 FridaCodeManager is free software: you can redistribute it and/or modify 
 it under the terms of the GNU General Public License as published by 
 the Free Software Foundation, either version 3 of the License, or 
 (at your option) any later version. 

 FridaCodeManager is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of 
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 GNU General Public License for more details. 

 You should have received a copy of the GNU General Public License 
 along with FridaCodeManager. If not, see <https://www.gnu.org/licenses/>. 
 */ 
    
import Foundation

func apicall(_ text: String,_ proj:Project) -> String {
    var ret = text
    ret = ret.replacingOccurrences(of: "<apiver>", with: "0.2")
    ret = ret.replacingOccurrences(of: "<fcmver>", with: "\(global_version)")
    ret = ret.replacingOccurrences(of: "<bundle>", with: "\(proj.BundleID)")
    ret = ret.replacingOccurrences(of: "<app>", with: "\(proj.Executable)")
    ret = ret.replacingOccurrences(of: "<host>", with: ghost())
    ret = ret.replacingOccurrences(of: "<cpu>", with: gcpu())
    ret = ret.replacingOccurrences(of: "<arch>", with: garch())
    ret = ret.replacingOccurrences(of: "<model>", with: gmodel())
    ret = ret.replacingOccurrences(of: "<osname>", with: gos())
    ret = ret.replacingOccurrences(of: "<osver>", with: gosver())
    ret = ret.replacingOccurrences(of: "<project-path>", with: "\(proj.ProjectPath)")
    ret = ret.replacingOccurrences(of: "<theos-path>", with: "\(Bundle.main.bundlePath)/include")
    ret = ret.replacingOccurrences(of: "<container-path>", with: "\(global_documents)/../")
    ret = repla(ret)
    ret = rsc(ret)
    return ret
}

func repla(_ inputString: String) -> String {
    // Split the string into lines
    let lines = inputString.split(separator: "\n")
    
    // Trim each line and store the results
    let trimmedLines = lines.map { $0.trimmingCharacters(in: .whitespaces) }
    
    // Join the trimmed lines with " ; " as the delimiter
    return trimmedLines.joined(separator: " ; ")
}

func rsc(_ inputString: String) -> String {
    var trimmedString = inputString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if trimmedString.hasPrefix("; ") {
        trimmedString.removeFirst()
    }
    
    if trimmedString.hasSuffix(" ;") {
        trimmedString.removeLast()
    }
    
    return trimmedString
}
