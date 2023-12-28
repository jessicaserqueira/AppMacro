import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public enum CompilationConfiguration {
    case debug, beta, release
}

public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
    
  
        let debug = node.argumentList.first?.expression ?? ExprSyntax.init(stringLiteral: "")
        let release = node.argumentList.last?.expression ?? ExprSyntax.init(stringLiteral: "")


        let code = """
                {
                #if DEBUG
                \(debug)()
                #elseif RELEASE
                \(release)()
                #endif
                }()
                """
        
        return "\(raw: code)"
    }
}

public struct DebugStringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        #if DEBUG
        return node.argumentList.first?.expression ?? ExprSyntax.init(stringLiteral: "")
        #else
        return ExprSyntax.init(stringLiteral: "")
        #endif
    }
}

public struct BetaStringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        #if BETA
        return node.argumentList.first?.expression ?? ExprSyntax.init(stringLiteral: "")
        #else
        return ExprSyntax.init(stringLiteral: "")
        #endif
    }
}

public struct ReleaseStringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        #if RELEASE
        return node.argumentList.first?.expression ?? ExprSyntax.init(stringLiteral: "")
        #else
        return ExprSyntax.init(stringLiteral: "")
        #endif
    }
}

@main
struct TestemacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}
