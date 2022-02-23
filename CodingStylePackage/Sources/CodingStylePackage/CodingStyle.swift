//
//  MyClass.swift
//  PropertyWrapperCodingStyle
//
//  Created by Евгений Старшов on 23.02.2022.
//

import Darwin

@propertyWrapper

public struct CodingStyle {
    
    public enum Style: String {
        case camelCase = " "
        case snakeCase = "_"
        case kebabCase = "-"
    }
    
    private var value: String
    private var style: Style
    
    public var wrappedValue: String {
        get {}
        set {}
    }
    
    public var projectedValue: Style {
        get { style }
        set { style = newValue }
    }
    
    public init (wrappedValue: String, style: Style) {
        self.value = wrappedValue
        self.style = style
    }
    
    //MARK: Convertation of String to given style
    
    private func placeSpacesBeforeCapitalLetters() -> String {
        
        var newString: String = ""
        
        value.forEach { character in
            
            if character.isUppercase { newString.append(" ")}
            newString.append(character)
        }
        if newString.first == " " { newString.removeFirst() }
        
        return newString
    }
    
    private func getSubSequence() -> [String] {
        let subStrings: [String] = placeSpacesBeforeCapitalLetters().split { separate in
            
            if separate == " " || separate == "-" || separate == "_" { return true }
            return false
            
        }.map { String($0).lowercased() }
        
        return subStrings
    }
    
    private func concatenation(array: [String]) -> String {
        
        var output: String = ""
        
        switch style {
        
        case .camelCase:
            array.forEach { output += $0.prefix(1).uppercased() + $0.dropFirst() }
        
        default:
            array.forEach { output += $0 + style.rawValue }
            if !output.isEmpty { output.removeLast() }
        }
        
        return output
    }
    
}


